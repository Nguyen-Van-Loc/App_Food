// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lab5/changeNotifier/ProfileUser.dart';
import 'package:provider/provider.dart';

import '../changeNotifier/Categories.dart';

class Rating {
  final double stars;
  final String comment;

  Rating(this.stars, this.comment);
}

class productReviews extends StatefulWidget {
  final String Name;
  final String Image;
  final String keyIdCa;
  final String keyId;
  final String keyIdHis;

  const productReviews(
      {super.key,
      required this.Name,
      required this.Image,
      required this.keyIdCa,
      required this.keyId,
      required this.keyIdHis});

  @override
  State<productReviews> createState() => _productReviewsState();
}

class _productReviewsState extends State<productReviews> {
  final firestore = FirebaseFirestore.instance;
  int _rating = 5;
  File? imageFile;
  String? linkImg;
  final TextEditingController _commentController = TextEditingController();

  void _updateRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  List<XFile?> imageFiles = [];
  List<String> imageUrls = [];

  Future<void> pickImage() async {
    if (imageFiles.length >= 4) {
      EasyLoading.showError("Bạn chỉ có thể thêm tối đa 4 ảnh");
      return;
    }
    setState(() {
      isLoading = true;
    });
    final picker = ImagePicker();
    final images = await picker.pickMultiImage();

    for (var image in images) {
      if (imageFiles.length < 4) {
        final user = FirebaseAuth.instance.currentUser;
        final Reference storageReference = FirebaseStorage.instance.ref().child(
            'imagesComment/${user!.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg');
        UploadTask uploadTask = storageReference.putFile(File(image.path));
        await uploadTask.whenComplete(() {});
        final imageUrl = await storageReference.getDownloadURL();
        setState(() {
          if (imageFiles.length < 4) {
            imageFiles.add(image);
            imageUrls.add(imageUrl);
          }
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void getImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      String imagePath = 'images/$userId/logo.png';
      String downloadURL = await FirebaseStorage.instance
          .ref()
          .child(imagePath)
          .getDownloadURL();
      setState(() {
        linkImg = downloadURL;
      });
    }
  }

  bool isLoading = false;

  void send() async {
    final item = Provider.of<getOderUser>(context, listen: false);
    final itemUser = Provider.of<getProflieUser>(context, listen: false);
    itemUser.fetchData();
    if (itemUser.data.isNotEmpty) {
      item.fetchDataOder(itemUser.data[0]["key"]);
    }
    final itemBander = Provider.of<getBander>(context, listen: false);
    itemBander.fetchDataBander();
    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
    itemUser.fetchData();
    firestore
        .collection("Categories")
        .doc(widget.keyIdCa)
        .collection("products")
        .doc(widget.keyId)
        .collection("Review")
        .add({
      "productName": widget.Name,
      "productsImage": widget.Image,
      "numberofStars": _rating,
      "comment": _commentController.text,
      "username": itemUser.data[0]["data"]["username"],
      "CreatedDate": formattedDate,
      "imageUrls": imageUrls,
      "imageUser": linkImg!,
    });
    firestore
        .collection("User")
        .doc(itemUser.data[0]["key"])
        .collection("History")
        .doc(widget.keyIdHis)
        .update({"reviewed": true});
    EasyLoading.showSuccess("Đánh giá thành công!");
    await Future.delayed(const Duration(seconds: 3));
    firestore
        .collection("Categories")
        .doc(widget.keyIdCa)
        .collection("products")
        .doc(widget.keyId)
        .update({"sumStart": averageRating, "sumComment": reviewCount});
    String banderID = itemBander.getBanderID(widget.keyId);
    firestore
        .collection("Bander")
        .doc(banderID)
        .update({"sumStart": averageRating, "sumComment": reviewCount});
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }

  String averageRating = "";
  int? reviewCount;

  @override
  Widget build(BuildContext context) {
    final itemRe = Provider.of<categoryProducts>(
      context,
    );
    itemRe.productReview(widget.keyIdCa, widget.keyId);
    int sumStart = 0;
    reviewCount = itemRe.data.length;
    if (itemRe.data.isNotEmpty) {
      for (int i = 0; i < reviewCount!; i++) {
        sumStart += (itemRe.data[i]['data']['numberofStars'] as num).toInt();
      }
      averageRating = (sumStart / itemRe.data.length).toStringAsFixed(1);
    } else {
      averageRating = "No ratings";
    }
    List<Widget> imageWidgets = [];
    for (int i = 0; i < imageFiles.length; i++) {
      imageWidgets.add(
        Stack(
          children: [
            Container(
              width: 90,
              height: 90,
              margin: const EdgeInsets.only(right: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ],
              ),
              child: Image.file(
                File(imageFiles[i]!.path),
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    imageFiles.removeAt(i);
                    imageUrls.removeAt(i);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12), // Làm tròn góc
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (imageFiles.length < 4) {
      if (isLoading) {
        imageWidgets.add(
          Container(
            width: 90,
            height: 90,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
        );
      } else {
        imageWidgets.add(
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: const Offset(1, 1),
                  color: Colors.grey.withOpacity(0.5),
                ),
              ],
            ),
            child: InkWell(
              onTap: () => pickImage(),
              child: const Icon(Icons.image),
            ),
          ),
        );
      }
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, top: 15),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFFB0AEAE)),
                        child: Image.asset(
                          "assets/image/left-chevron.png",
                          width: 20,
                          height: 20,
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Đánh giá sản phẩm",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "LibreBodoni-BoldItalic"),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: 5,
              color: const Color(0xffe7e6e6),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          widget.Image,
                          height: 70,
                          width: 70,
                        ),
                        SizedBox(
                            width: 300,
                            child: Text(
                              widget.Name,
                              style: const TextStyle(fontSize: 17),
                              overflow: TextOverflow.ellipsis,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: const Color(0xffe7e6e6),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                            width: 100,
                            child: Text(
                              "Chất lượng sản phẩm ",
                              style: TextStyle(fontSize: 16),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.star),
                              color: _rating >= 1 ? Colors.amber : Colors.grey,
                              onPressed: () => _updateRating(1),
                            ),
                            IconButton(
                              icon: const Icon(Icons.star),
                              color:
                                  _rating >= 2.0 ? Colors.amber : Colors.grey,
                              onPressed: () => _updateRating(2),
                            ),
                            IconButton(
                              icon: const Icon(Icons.star),
                              color:
                                  _rating >= 3.0 ? Colors.amber : Colors.grey,
                              onPressed: () => _updateRating(3),
                            ),
                            IconButton(
                              icon: const Icon(Icons.star),
                              color:
                                  _rating >= 4.0 ? Colors.amber : Colors.grey,
                              onPressed: () => _updateRating(4),
                            ),
                            IconButton(
                              icon: const Icon(Icons.star),
                              color:
                                  _rating >= 5.0 ? Colors.amber : Colors.grey,
                              onPressed: () => _updateRating(5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: const Color(0xffe7e6e6),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Đánh giá về sản phẩm ",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          style: const TextStyle(fontSize: 17),
                          controller: _commentController,
                          maxLines: 9,
                          decoration: const InputDecoration(
                              hintText:
                                  "Hãy để lại nhận xét của bạn về sản phẩm nhé!",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(10)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Thêm ảnh",
                            style: TextStyle(fontSize: 17),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: imageWidgets)
                        ]),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: ElevatedButton(
                      onPressed: _commentController.text.isEmpty
                          ? null
                          : () {
                              send();
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffff6900),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        "Gửi",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "LibreBodoni-MediumItalic",
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

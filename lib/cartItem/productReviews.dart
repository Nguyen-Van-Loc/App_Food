import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lab5/changeNotifier/ProfileUser.dart';
import 'package:provider/provider.dart';
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
  const productReviews({super.key,required this.Name,required this.Image ,required this.keyIdCa,required this.keyId});

  @override
  State<productReviews> createState() => _productReviewsState();
}

class _productReviewsState extends State<productReviews> {
  final firestore =FirebaseFirestore.instance;
  double _rating = 5.0;
  File? imageFile;
  String? linkImg;
  TextEditingController _commentController = TextEditingController();
  List<Rating> _ratings = [];
  void _updateRating(double rating) {
    setState(() {
      _rating = rating;
    });
  }
  void _submitRating() {
    setState(() {
      _ratings.add(Rating(_rating, _commentController.text));
      _rating = 0.0;
      _commentController.clear();
    });
  }
  List<XFile?> imageFiles = [];
  List<String> imageUrls = [];
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final user = FirebaseAuth.instance.currentUser;
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('imagesComment/${user!.uid}/image.png');
      UploadTask uploadTask = storageReference.putFile(File(image.path));
      await uploadTask.whenComplete(() {});
      final imageUrl = await storageReference.getDownloadURL();
      setState(() {
        imageUrls.add(imageUrl);
        imageFiles.add(image);
      });
    }
    print(imageUrls);
  }
  void send(){
  //   final now = DateTime.now();
  //   final formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
  //   final itemUser =Provider.of<getProflieUser>(context,listen: false);
  //   itemUser.fetchData();
  //   firestore.collection("Categories").doc(widget.keyIdCa).collection("products").doc(widget.keyId).collection("Review").add({
  //     "productName": widget.Name,
  //     "productsImage":widget.Image,
  //     "numberofStars": _rating,
  //     "comment":_commentController.text,
  //     "username":itemUser.data[0]["data"]["username"],
  //     "CreatedDate":formattedDate
  //   });
  }
  @override
  Widget build(BuildContext context) {

    List<Widget> imageWidgets = [];
    for (int i = 0; i < imageFiles.length; i++) {
      imageWidgets.add(
         Container(
            width: 90,
            height: 90,
            margin: EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(1, 1),
                  color: Colors.grey.withOpacity(0.5),
                ),
              ],
            ),
            child: InkWell(
              onTap: () => pickImage(),
              child:imageFiles[i] != null
                ? Image.file(File(imageFiles[i]!.path),fit: BoxFit.fill,)
                : Icon(Icons.image),
          ),
        ),
      );
    }
    if (imageFiles.length < 4) {
      imageWidgets.add(
         Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(1, 1),
                  color: Colors.grey.withOpacity(0.5),
                ),
              ],
            ),
            child: InkWell(
              onTap: () => pickImage(),
              child:Icon(Icons.image),
          ),
        ),
      );
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
                      Navigator.pop(context);
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
            Expanded(child:
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(widget.Image,height: 70,width: 70,),
                        Container(width:300,child: Text(widget.Name,style: TextStyle(fontSize: 17),overflow: TextOverflow.ellipsis,))
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
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 100,child: Text("Chất lượng sản phẩm ",style: TextStyle(fontSize: 16),)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.star),
                              color: _rating >= 1.0 ? Colors.amber : Colors.grey,
                              onPressed: () => _updateRating(1.0),
                            ),
                            IconButton(
                              icon: Icon(Icons.star),
                              color: _rating >= 2.0 ? Colors.amber : Colors.grey,
                              onPressed: () => _updateRating(2.0),
                            ),
                            IconButton(
                              icon: Icon(Icons.star),
                              color: _rating >= 3.0 ? Colors.amber : Colors.grey,
                              onPressed: () => _updateRating(3.0),
                            ),
                            IconButton(
                              icon: Icon(Icons.star),
                              color: _rating >= 4.0 ? Colors.amber : Colors.grey,
                              onPressed: () => _updateRating(4.0),
                            ),
                            IconButton(
                              icon: Icon(Icons.star),
                              color: _rating >= 5.0 ? Colors.amber : Colors.grey,
                              onPressed: () => _updateRating(5.0),
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
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Đánh giá về sản phẩm " ,style: TextStyle(fontSize: 18),),
                        SizedBox(height: 10,),
                        TextField(
                          style: TextStyle(
                            fontSize: 17
                          ),
                          controller: _commentController,
                          maxLines: 9,
                          decoration: InputDecoration(
                            hintText: "Hãy để lại nhận xét của bạn về sản phẩm nhé!",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(10)
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Thêm ảnh",style: TextStyle(fontSize: 17),),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: imageWidgets
                        )
                    ]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    child: ElevatedButton(
                      onPressed: () {
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

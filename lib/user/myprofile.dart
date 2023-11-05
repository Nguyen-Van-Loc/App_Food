// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lab5/Validate/validateProfile.dart';
import 'package:shimmer/shimmer.dart';
class myProfile extends StatefulWidget {
  @override
  viewMyProfile createState() => viewMyProfile();
  final Map<String, dynamic> data;
  final String keyId;
  const myProfile({super.key, required this.data, required this.keyId});
}
class viewMyProfile extends State<myProfile> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int select = 0;
  String errname = "", errphone = "";
  final _sexControler = TextEditingController();
  final _dateControler = TextEditingController();
  final _usernameControler = TextEditingController();
  final _phoneControler = TextEditingController();
  File? imageFile;
  String? linkImg;

  Future<File?> pickImage() async {
    final imagePicker = ImagePicker();
    final XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        imageFile = File(selectedImage.path);
      });
    }
    return null;
  }
  void getImage()async{
    User? user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      String userId = user.uid;
      String imagePath = 'images/$userId/logo.png';
      String downloadURL =
      await FirebaseStorage.instance.ref().child(imagePath).getDownloadURL();
      setState(() {
        linkImg = downloadURL;
      });
    }
  }
  Future<void> uploadImage(File imageFile) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      String imagePath = 'images/$userId/logo.png';
      Reference storageRef = FirebaseStorage.instance.ref().child(imagePath);
      UploadTask uploadTask = storageRef.putFile(imageFile);
        await uploadTask.whenComplete(() {
        });
    }
  }

  void onUpdate() async {
    setState(() {
      errname = validateName(_usernameControler.text);
    });
    if (errname.isEmpty) {
      setState(() {
        errphone = validateName(_phoneControler.text);
      });
      if (errphone.isEmpty) {
        EasyLoading.show(status: "loading...");
        await Future.delayed(const Duration(seconds: 3));
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Cập nhật thành công");
        Update();
      }
    }
  }

  Future<void> Update() async {
    final updateNv = {
      "date": _dateControler.text,
      "phone": _phoneControler.text,
      "sex": _sexControler.text,
      "username": _usernameControler.text,
    };
    if(imageFile!=null){
      await uploadImage(imageFile!);
    }
    firestore.collection("User").doc(widget.keyId).update(updateNv);
    Navigator.pop(context);
  }
  Widget customRadio(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          select = index;
        });
        _sexControler.text = text;
        Navigator.pop(context);
      },
      child: SizedBox(
          width: double.infinity,
          child: Text(
            text,
            style:
                const TextStyle(fontSize: 15, fontFamily: "LibreBodoni-Medium"),
          )),
    );
  }

  @override
  void initState(){
    super.initState();
    _usernameControler.text = widget.data["username"];
    _phoneControler.text = widget.data["phone"];
    _sexControler.text = widget.data["sex"];
    _dateControler.text = widget.data["date"];
    getImage();
  }
  void dialogSex() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Giới tính",
                    style: TextStyle(
                        fontSize: 20, fontFamily: "LibreBodoni-Medium"),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: const Color(0xffe7e6e6),
                  ),
                  customRadio("Nam", 1),
                  customRadio("Nữ", 2),
                  customRadio("Khác", 3),
                ],
              ),
            ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _sexControler.clear();
    _phoneControler.clear();
    _dateControler.clear();
    _usernameControler.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      "Hồ sơ của tôi",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "LibreBodoni-BoldItalic"),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: 5,
                color: const Color(0xffe7e6e6),
              ),
              InkWell(
                  onTap: () =>pickImage(),
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(blurRadius: 4,offset: const Offset(1,1),color: Colors.grey.withOpacity(0.5))
                          ]
                        ),
                        child: imageFile != null
                            ? Image.file(imageFile!)
                            : linkImg != null
                            ? Image.network(linkImg!)
                            : Shimmer.fromColors(baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!, child: Container(height: 100,color: Colors.white,),)
                  ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                            padding: const EdgeInsets.only(top: 3),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                              color: Colors.grey.withOpacity(.5),
                            ),
                            width: 100,
                            height: 20,
                            child: const Text(
                              "Ảnh",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Tên người dùng",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium", fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _usernameControler,
                        decoration: InputDecoration(
                          errorText: errname.isNotEmpty ? errname : null,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          hintText: "Tên người dùng",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _usernameControler.clear();
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Giới tính",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium", fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () => dialogSex(),
                        child: TextField(
                          controller: _sexControler,
                          enabled: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            hintText: "Giới tính",
                            suffixIcon: IconButton(
                              icon: const Icon(
                                  Icons.arrow_drop_down_circle_outlined),
                              onPressed: () {},
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Ngày sinh",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium", fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          var datePicked =
                              await DatePicker.showSimpleDatePicker(context,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2090),
                                  dateFormat: "dd-" "thg" "MM-yyyy",
                                  locale: DateTimePickerLocale.en_us,
                                  looping: true);
                          String formattedDate =
                              DateFormat("dd-MM-yyyy").format(datePicked!);
                          _dateControler.text = formattedDate;
                        },
                        child: TextField(
                          controller: _dateControler,
                          enabled: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            hintText: "Ngày sinh",
                            suffixIcon: IconButton(
                              icon: const Icon(
                                  Icons.arrow_drop_down_circle_outlined),
                              onPressed: () {},
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Số điện thoại",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium", fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _phoneControler,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          errorText: errphone.isNotEmpty ? errphone : null,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          hintText: "Số điện thoại",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _phoneControler.clear();
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  onUpdate();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffff6900),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 40),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  "Xác nhận",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "LibreBodoni-MediumItalic",
                      fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

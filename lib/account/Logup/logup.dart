import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lab5/Validate/validateProfile.dart';
import 'package:lab5/Validate/validateLogin.dart';
import 'package:lab5/account/Login/login.dart';
import 'package:restart_app/restart_app.dart';

class logup extends StatefulWidget {
  const logup({super.key});

  @override
  viewLogup createState() => viewLogup();
}

class viewLogup extends State<logup> {
  final  _firestore = FirebaseFirestore.instance;
  String erruser = "", erremail = "", errpass = "", errrepass = "";
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _repassController = TextEditingController();
  bool checkkey = true;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void onAdd() async{
    setState(() {
      erruser = validateName(_usernameController.text);
    });
    if (erruser.isEmpty) {
      setState(() {
        erremail = validateEmail(_emailController.text);
      });
      if (erremail.isEmpty) {
        setState(() {
          errpass = validatePassword(_passController.text);
        });
        if (errpass.isEmpty) {
          setState(() {
            errrepass = validateRePassword(
                _repassController.text, _passController.text);
          });
          if (errrepass.isEmpty) {
            EasyLoading.show(status:"loading...");
            bool success = await _addUser();
            if(success){
              await Future.delayed(const Duration(seconds: 3));
              Restart.restartApp();
            }
          }
        }
      }
    }
  }
  Future<bool> _addUser() async {
    String email = _emailController.text;
    String password = _passController.text;
    try {
      final UserCredential() =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("User").add({
        "username": _usernameController.text,
        "phone": "",
        "date": "",
        "sex": "",
        "address": [],
        "email":email,
      });
      User? user = FirebaseAuth.instance.currentUser;
      String userId = user!.uid;
      final assetImage = await rootBundle.load('assets/image/Group 107.png');
      Reference storageRef = FirebaseStorage.instance.ref().child('images/$userId/logo.png');
      await storageRef.putData(assetImage.buffer.asUint8List());
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        EasyLoading.showError("Email đã được sử dụng");
        return false;
      }
    } catch (e) {
      return false;
    }
    EasyLoading.dismiss();
    return false;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.clear();
    _emailController.clear();
    _repassController.clear();
    _passController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Image.asset(
                  "assets/image/Group 97.png",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                )),
            Positioned(
                left: 0,
                right: 0,
                top: -30,
                child: Image.asset(
                  "assets/image/logo.png",
                  height: 300,
                  width: 300,
                )),
            Positioned(
              top: 180,
              left: 20,
              right: 20,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(0, 4))
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tên người dùng",
                        style: TextStyle(
                            fontSize: 16, fontFamily: "LibreBodoni-Medium"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            errorText: erruser.isNotEmpty?erruser:null,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 17,
                            ),
                            hintText: "Tên người dùng",
                            prefixIcon: Container(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/image/user.png",
                                  height: 20,
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 16, fontFamily: "LibreBodoni-Medium"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            errorText: erremail.isNotEmpty?erremail:null,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 17,
                            ),
                            hintText: "Nhập Email",
                            prefixIcon: Container(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/image/mail.png",
                                  height: 20,
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Mật khẩu",
                        style: TextStyle(
                            fontSize: 16, fontFamily: "LibreBodoni-Medium"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _passController,
                        obscureText: checkkey,
                        decoration: InputDecoration(
                            errorText: errpass.isNotEmpty?errpass:null,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 17,
                            ),
                            hintText: "Nhập mật khẩu",
                            prefixIcon: Container(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/image/key.png",
                                  height: 20,
                                )),
                            suffixIcon: InkWell(
                              onTap: () => setState(() {
                                checkkey = !checkkey;
                              }),
                              child: checkkey
                                  ? const Icon(CupertinoIcons.eye_slash)
                                  : const Icon(CupertinoIcons.eye),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Nhập lại Mật khẩu",
                        style: TextStyle(
                            fontSize: 16, fontFamily: "LibreBodoni-Medium"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _repassController,
                        obscureText: checkkey,
                        decoration: InputDecoration(
                            errorText: errrepass.isNotEmpty?errrepass:null,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 17,
                            ),
                            hintText: "Nhập lại mật khẩu",
                            prefixIcon: Container(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/image/key.png",
                                  height: 20,
                                )),
                            suffixIcon: InkWell(
                              onTap: () => setState(() {
                                checkkey = !checkkey;
                              }),
                              child: checkkey
                                  ? const Icon(CupertinoIcons.eye_slash)
                                  : const Icon(CupertinoIcons.eye),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            onAdd();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor: const Color(0xffFF3D00),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 35)),
                          child: const Text(
                            "Đăng ký",
                            style: TextStyle(
                                fontSize: 16, fontFamily: "LibreBodoni-Medium"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Bạn đã có tài khoản ?",
                            style: TextStyle(
                            color: Color(0xffA3A3A3),
                            fontSize: 15,
                            fontFamily: "LibreBodoni-Medium"),
                          ),
                          TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => const login())),
                              child: const Text(
                                "Đăng nhập",
                                style: TextStyle(
                                    color: Color(0xffFF6C2E),
                                    fontSize: 16,
                                    fontFamily: "LibreBodoni-Medium"),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: InkWell(
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
            ),
          ],
        ),
      ),
    );
  }
}

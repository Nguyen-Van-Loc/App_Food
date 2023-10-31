import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lab5/User/user.dart';
import 'package:lab5/Validate/validateLogin.dart';
import 'package:lab5/Validate/validateProfile.dart';
import 'package:restart_app/restart_app.dart';

class viewPass extends State<mypass> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool checkpass = true;
  final passNewController = TextEditingController();
  final repassNewController = TextEditingController();
  String errPassNew = "", errRePassNew = "";

  void onPass() async {
    setState(() {
      errPassNew = validatePassNew(passNewController.text);
    });
    if (errPassNew.isEmpty) {
      setState(() {
        errRePassNew = validateRePassword(
            repassNewController.text, passNewController.text);
      });
      if (errRePassNew.isEmpty) {
        User? user = FirebaseAuth.instance.currentUser;
        await user!.updatePassword(passNewController.text);
        EasyLoading.show(status: "loading...");
        await Future.delayed(const Duration(seconds: 3));
        EasyLoading.dismiss();
        EasyLoading.showSuccess(
            "Đổi mật khẩu thành công !\n Vui lòng đăng nhập lại ứng dụng. ");
        await Future.delayed(const Duration(seconds: 3));
        await _auth.signOut();
        Restart.restartApp();
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passNewController.clear();
    repassNewController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    "Đổi mật khẩu",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "LibreBodoni-BoldItalic"),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 5,
              color: const Color(0xffe7e6e6),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nhập mật khẩu mới",
                    style: TextStyle(
                        fontFamily: "LibreBodoni-Medium", fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passNewController,
                    obscureText: checkpass,
                    decoration: InputDecoration(
                        errorText: errPassNew.isNotEmpty ? errPassNew : null,
                        hintText: "Nhập mật khẩu mới",
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                checkpass = !checkpass;
                              });
                            },
                            child: checkpass
                                ? const Icon(CupertinoIcons.eye_slash)
                                : const Icon(CupertinoIcons.eye)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nhập lại mật khẩu mới",
                    style: TextStyle(
                        fontFamily: "LibreBodoni-Medium", fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: repassNewController,
                    obscureText: checkpass,
                    decoration: InputDecoration(
                        errorText:
                            errRePassNew.isNotEmpty ? errRePassNew : null,
                        hintText: "Nhập lại mật khẩu ",
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                checkpass = !checkpass;
                              });
                            },
                            child: checkpass
                                ? const Icon(CupertinoIcons.eye_slash)
                                : const Icon(CupertinoIcons.eye)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                onPass();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffff6900),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
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
          ],
        ),
      ),
    );
  }
}

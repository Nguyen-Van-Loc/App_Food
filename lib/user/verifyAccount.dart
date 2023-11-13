// ignore_for_file: file_names, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lab5/User/user.dart';

class verifyAccount extends StatefulWidget {
  const verifyAccount({super.key});

  @override
  viewVerifyAccount createState() => viewVerifyAccount();
}
class viewVerifyAccount extends State<verifyAccount> {
  String errPassOld = "";
  final passOldController = TextEditingController();
  bool checkpassold = true, checkbutton = false;

  void check(String passOld) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: passOld,
      );
      if (passOldController.text.length < 6) {
        setState(() {
          errPassOld = "Mật khẩu cũ lớn hơn 6 kí tự";
        });
        return;
      }
      try {
        await user.reauthenticateWithCredential(credential);
        EasyLoading.show(status: "Đang xác minh tài khoản");
        await Future.delayed(const Duration(seconds: 3));
        EasyLoading.dismiss();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (context) => const mypass()));
      } catch (e) {
        setState(() {
          errPassOld = "Mật khẩu cũ không đúng";
        });
        return;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passOldController.addListener(() {
        checkbutton = passOldController.text.isNotEmpty;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passOldController.clear();
  }
  @override
  Widget build(BuildContext context) {
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
                    "Xác minh tài khoản",
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
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Vui lòng nhập mật khẩu hiện tại của bạn để xác minh",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                      onChanged: (text) {
                        setState(() {});
                      },
                      controller: passOldController,
                      obscureText: checkpassold,
                      decoration: InputDecoration(
                          errorText:
                              errPassOld.isNotEmpty ? errPassOld : null,
                          filled: true,
                          hintText: "Mật khẩu",
                          fillColor: Colors.white,
                          suffixIcon: Container(
                            width: 50,
                            margin: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                passOldController.text.isNotEmpty
                                    ? InkWell(
                                  onTap: () {
                                    passOldController.clear();
                                  },
                                  child: const Icon(Icons.clear),
                                )
                                    : const SizedBox.shrink(),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        checkpassold = !checkpassold;
                                      });
                                    },
                                    child: checkpassold
                                        ? const Icon(CupertinoIcons.eye_slash)
                                        : const Icon(CupertinoIcons.eye)),

                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                width: 1,
                              )))),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: passOldController.text.isNotEmpty
                          ? () {
                              check(passOldController.text);
                            }
                          : null,
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
                            fontFamily: "LibreBodoni-MediumItalic",
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

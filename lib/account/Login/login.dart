// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lab5/account/Login/forgotPassword.dart';
import 'package:lab5/account/Logup/logup.dart';
import 'package:restart_app/restart_app.dart';

import '../../Validate/validateLogin.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  viewLogin createState() => viewLogin();
}

class viewLogin extends State<login> {
  String erremail = "", errpass = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool checkkey = true;

  void onLogin() async {
    setState(() {
      erremail = validateEmail(_emailController.text);
    });
    if (erremail.isEmpty) {
      setState(() {
        errpass = validatePassword(_passwordController.text);
      });
      if (errpass.isEmpty) {
        EasyLoading.show(status: "loading...");
        await Future.delayed(const Duration(seconds: 3));
        bool success = await _signIn();
        if(success){
          await Future.delayed(const Duration(seconds: 3));
          Restart.restartApp();
        }
      }
    }
  }

  Future<bool> _signIn() async {
    // EasyLoading.show(status: "loading...");
    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      final UserCredential() = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.toString().trim(),
              password: password.toString().trim());
      return true;
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Tài khoản hoặc mật khẩu không chính xác");
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.clear();
    _passwordController.clear();
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
                  "assets/image/Group 96.png",
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
              top: 200,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: 450,
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
                    const SizedBox(
                      height: 15,
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
                          errorText: erremail.isNotEmpty ? erremail : null,
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
                      controller: _passwordController,
                      obscureText: checkkey,
                      decoration: InputDecoration(
                          errorText: errpass.isNotEmpty ? errpass : null,
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
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const forgotPassword()));
                          },
                          child: const Text(
                            "Quên mật khẩu ?",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff9A9A9A),
                                fontFamily: "LibreBodoni-Bold"),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () => onLogin(),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: const Color(0xffFF3D00),
                            padding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 35)),
                        child: const Text(
                          "Đăng nhập",
                          style: TextStyle(
                              fontSize: 18, fontFamily: "LibreBodoni-Medium"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Bạn chưa có tài khoản ?",
                          style: TextStyle(
                          color: Color(0xffA3A3A3),
                          fontSize: 15,
                          fontFamily: "LibreBodoni-Medium"),
                        ),
                        TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const logUp())),
                            child: const Text(
                              "Đăng ký",
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab5/User/user.dart';

class viewPass extends State<mypass> {
  bool checkpass = true;
  bool checkpassold = true;
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
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nhập mật khẩu cũ",
                    style: TextStyle(
                        fontFamily: "LibreBodoni-Medium", fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 4,
                          offset: Offset(0, 4))
                    ]),
                    child: TextField(
                      obscureText: checkpassold,
                      decoration: InputDecoration(
                        filled: true,
                          fillColor: Colors.white,
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  checkpassold = !checkpassold;
                                });
                              },
                              child: checkpassold
                                  ? Icon(CupertinoIcons.eye_slash)
                                  : Icon(CupertinoIcons.eye)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13)
                          )),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nhập mật khẩu mới",
                    style: TextStyle(
                        fontFamily: "LibreBodoni-Medium", fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 4,
                          offset: Offset(0, 4))
                    ]),
                    child: TextField(
                      obscureText: checkpass,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  checkpass = !checkpass;
                                });
                              },
                              child: checkpass
                                  ? Icon(CupertinoIcons.eye_slash)
                                  : Icon(CupertinoIcons.eye)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(width: 0.1,color: Colors.grey)
                          )),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nhập lại mật khẩu mới",
                    style: TextStyle(
                        fontFamily: "LibreBodoni-Medium", fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 4,
                          offset: Offset(0, 4))
                    ]),
                    child: TextField(
                      obscureText: checkpass,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  checkpass = !checkpass;
                                });
                              },
                              child: checkpass
                                  ? Icon(CupertinoIcons.eye_slash)
                                  : Icon(CupertinoIcons.eye)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13)
                          )),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffff6900),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lab5/account/Login/login.dart';
import 'package:lab5/account/Logup/logup.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class viewProfile extends State<profile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
    EasyLoading.dismiss();
  }
  Future<void> _checkAuthentication() async {
    User? user = _auth.currentUser;
    setState(() {
      _user = user;
    });
  }
  void _logoutAndRestartApp() async {
    await _auth.signOut();
    EasyLoading.show(status: "loading...");
    await Future.delayed(Duration(seconds: 3));
    // Restart.restartApp();
  }
  void dialogsupport(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
            child: Text("Trung tâm hỗ trợ",
                style: const TextStyle(fontFamily: "LibreBodoni-Medium")),
          ),
          content:
          Text("Mọi thắc mắc vui lòng liên hệ \nHotline: 19001006 ."),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 13, horizontal: 30),
                    backgroundColor: const Color(0xffff6900),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Xác nhận"),
              ),
            )
          ],
        ));
  }
  @override
  Widget build(BuildContext context) {
    final item =Provider.of<getProflieUser>(context);
    item.fetchData();
    final username = item.data[0]["data"]["username"];
    return Scaffold(
      body: SafeArea(
        child: _user == null ?
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  child: Text(
                    "Người dùng chưa thể thực hiện chức năng này vui lòng Đăng nhập hoặc Đăng ký",style: TextStyle(fontSize: 18,fontFamily: "LibreBodoni-Medium"),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (context)=> login())),
                      child: Text(
                        "Đăng nhập",
                        style: TextStyle(
                            fontSize: 18, fontFamily: "LibreBodoni-Medium"),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Color(0xffFF3D00),
                          padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 35)),
                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (context)=> logup())),
                      child: Text(
                        "Đăng ký",
                        style: TextStyle(
                            fontSize: 18, fontFamily: "LibreBodoni-Medium"),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Color(0xffFF3D00),
                          padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 35)),
                    ),
                  ],
                )
              ],
            ),
          )
            : SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 20),
                child: const Text(
                  "Người dùng",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: "LibreBodoni-BoldItalic"),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 20),
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey,
                  ),
                ),
              ),
               Center(
                  child: Text(username,
                    style: TextStyle(
                        fontFamily: "LibreBodoni-BoldItalic", fontSize: 20),
                  )),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.75,
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    border:
                    Border.all(width: 1, color: const Color(0xffdedede)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) => user()));
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              left: 20,
                              child: Container(
                                padding:
                                const EdgeInsets.only(left: 80, top: 25),
                                margin: const EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width - 50,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                          color: Colors.grey.withOpacity(.4))
                                    ]),
                                child: const Text("Thiết lập tài khoản",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "LibreBodoni-Italic")),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 30, bottom: 20, top: 15),
                                  width: 60,
                                  height: 60,
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xffc0c0c0),
                                  ),
                                  child:
                                  Image.asset("assets/image/user (3).png"),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 15,bottom: 5),
                                  padding: const EdgeInsets.all(8),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xFFFBFBFB),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Image.asset("assets/image/next.png"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) => cart()));
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              left: 20,
                              top: 0,
                              child: Container(
                                padding:
                                const EdgeInsets.only(top: 25, left: 80),
                                margin: const EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width - 50,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                          color: Colors.grey.withOpacity(.4))
                                    ]),
                                child: const Text("Giỏ hàng",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "LibreBodoni-Italic")),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 30, bottom: 20, top: 15),
                                  width: 60,
                                  height: 60,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xffc0c0c0),
                                  ),
                                  child: Image.asset("assets/image/cart.png"),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 15,bottom: 5),
                                  padding: const EdgeInsets.all(8),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xFFFBFBFB),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Image.asset("assets/image/next.png"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () { Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => historycart()));},
                        child: Stack(
                          children: [
                            Positioned(
                              left: 20,
                              top: 0,
                              child: Container(
                                padding:
                                const EdgeInsets.only(top: 25, left: 80),
                                margin: const EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width - 50,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                          color: Colors.grey.withOpacity(.4))
                                    ]),
                                child: const Text("Lịch sử mua hàng",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "LibreBodoni-Italic")),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 30, bottom: 20, top: 15),
                                  width: 60,
                                  height: 60,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xffc0c0c0),
                                  ),
                                  child: Image.asset("assets/image/file.png"),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 15,bottom: 5),
                                  padding: const EdgeInsets.all(8),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xFFFBFBFB),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Image.asset("assets/image/next.png"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Stack(
                          children: [
                            Positioned(
                              left: 20,
                              top: 0,
                              child: Container(
                                padding:
                                const EdgeInsets.only(top: 25, left: 80),
                                margin: const EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width - 50,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                          color: Colors.grey.withOpacity(.4))
                                    ]),
                                child: const Text("Ví của tôi",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "LibreBodoni-Italic")),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 30, bottom: 20, top: 15),
                                  width: 60,
                                  height: 60,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xffc0c0c0),
                                  ),
                                  child: Image.asset("assets/image/wallet.png"),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 15,bottom: 5),
                                  padding: const EdgeInsets.all(8),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xFFFBFBFB),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Image.asset("assets/image/next.png"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          dialogsupport(context);
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              left: 20,
                              top: 0,
                              child: Container(
                                padding:
                                const EdgeInsets.only(top: 25, left: 80),
                                margin: const EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width - 50,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                          color: Colors.grey.withOpacity(.4))
                                    ]),
                                child: const Text("Trung tâm hỗ trợ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "LibreBodoni-Italic")),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 30, bottom: 20, top: 15),
                                  width: 60,
                                  height: 60,
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xffc0c0c0),
                                  ),
                                  child: Image.asset(
                                      "assets/image/programmer (1).png"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 40, top: 10, bottom: 10),
                          child: ElevatedButton.icon(
                            onPressed: () { _logoutAndRestartApp();},
                            label: const Text("Đăng xuất"),
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(15),
                                backgroundColor: Colors.red,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            icon: Image.asset(
                              "assets/image/exit.png",
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

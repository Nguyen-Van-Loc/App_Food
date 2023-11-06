// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lab5/cartItem/cart.dart';
import 'package:lab5/cartItem/historyCart.dart';
import 'package:lab5/user/user.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shimmer/shimmer.dart';
import '../changeNotifier/ProfileUser.dart';
import 'notifications.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  viewProfile createState() => viewProfile();
}
class viewProfile extends State<profile> with AutomaticKeepAliveClientMixin {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NotificationServices _services = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _services.requestNotificationServices();
    _services.firebaseInit(context);
    _services.getDeviceToken().then((value) {
    });
    _checkAuthentication();
    EasyLoading.dismiss();
    getImage();
  }
  Future<void> _checkAuthentication() async {
    setState(() {
    });
  }
  String? linkImg;
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
  void _logOut() async {
    await _auth.signOut();
    EasyLoading.show(status: "loading...");
    await Future.delayed(const Duration(seconds: 3));
    Restart.restartApp();
  }
  void dialogsupport(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Center(
            child: Text("Trung tâm hỗ trợ",
                style: TextStyle(fontFamily: "LibreBodoni-Medium")),
          ),
          content:
          const Text("Mọi thắc mắc vui lòng liên hệ \nHotline: 19001006 ."),
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
  void dialogSupport(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Center(
            child: Text("Trung tâm hỗ trợ",
                style: TextStyle(fontFamily: "LibreBodoni-Medium")),
          ),
          content:
          const Text("Tính năng đang phát triển !."),
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
    super.build(context);
    final itemCart=Provider.of<getCartUser>(context);
    final item =Provider.of<getProflieUser>(context);
    item.fetchData();
    final username = item.data.isNotEmpty? item.data[0]["data"]["username"]:"";
    if(item.data.isNotEmpty){
      itemCart.fetchDataCart(item.data[0]["key"]);
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
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
              Expanded(child: SingleChildScrollView(
                child: Column(children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 20),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:linkImg!=null  ? Image.network(linkImg!,fit: BoxFit.contain,): Shimmer.fromColors(baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!, child: Container(height: 100,color: Colors.white,),),
                    ),
                  ),
                  Center(
                      child: Text(username,
                        style: const TextStyle(
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
                                  CupertinoPageRoute(builder: (context) => const user()));
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
                                  CupertinoPageRoute(builder: (context) => const cart()));
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
                                    ),Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child: Text(itemCart.data.length.toString(),style: const TextStyle(color: Colors.white),),
                                        ),
                                        const SizedBox(width: 10,),
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
                                    )

                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () { Navigator.push(context,
                                CupertinoPageRoute(builder: (context) => const historycart()));},
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
                            onTap: () {dialogSupport(context);},
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
                                onPressed: () { _logOut();},
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
                ],),
              ))

            ],
          ),
        ),
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

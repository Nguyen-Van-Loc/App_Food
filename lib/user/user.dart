import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab5/main.dart';
import 'package:lab5/user/verifyAccount.dart';
import 'package:provider/provider.dart';
import '../changeNotifier/ProfileUser.dart';
import 'password.dart';
import 'address.dart';
import 'myprofile.dart';

class viewUser extends State<user> {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<getProflieUser>(context);
    item.fetchData();
    final itemData = item.data.isNotEmpty? item.data[0]:null;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15, top: 15),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFFB0AEAE)),
                        child: Image.asset(
                          "assets/image/left-chevron.png",
                          width: 20,
                          height: 20,
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Thiết lập tài khoản",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "LibreBodoni-BoldItalic"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width,
              height: 5,
              color: Color(0xffe7e6e6),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => myprofile(
                              data: itemData!["data"], keyId: itemData["key"])));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.grey.withOpacity(.5))
                      ]),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hồ sơ của tôi",
                          style: TextStyle(
                              fontSize: 18, fontFamily: "LibreBodoni-Medium"),
                        ),
                        Image.asset(
                          "assets/image/next.png",
                          height: 20,
                          width: 20,
                        )
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => myaddress(
                              data: itemData!["data"],
                              keyId: itemData["key"],
                            )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 10,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Colors.grey.withOpacity(.5))
                    ]),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Địa chỉ",
                        style: TextStyle(
                            fontSize: 18, fontFamily: "LibreBodoni-Medium"),
                      ),
                      Image.asset(
                        "assets/image/next.png",
                        height: 20,
                        width: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => verifyAccount()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.grey.withOpacity(.5))
                      ]),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Đổi mật khẩu",
                          style: TextStyle(
                              fontSize: 18, fontFamily: "LibreBodoni-Medium"),
                        ),
                        Image.asset(
                          "assets/image/next.png",
                          height: 20,
                          width: 20,
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class myprofile extends StatefulWidget {
  viewMyProfile createState() => viewMyProfile();
  final Map<String, dynamic> data;
  final String keyId;
  myprofile({required this.data, required this.keyId});
}

class myaddress extends StatefulWidget {
  viewAddress createState() => viewAddress();
  final Map<String, dynamic> data;
  final String keyId;
  myaddress({required this.data, required this.keyId});
}

class mypass extends StatefulWidget {
  viewPass createState() => viewPass();
}

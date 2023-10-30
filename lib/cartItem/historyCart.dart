import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:lab5/cartItem/informationProducst.dart';
import 'package:lab5/cartItem/productReviews.dart';
import 'package:lab5/changeNotifier/ProfileUser.dart';
import 'package:http/http.dart' as http;
import 'package:lab5/page/notifications.dart';
import 'package:provider/provider.dart';

class historycart extends StatefulWidget {
  viewhistoryCart createState() => viewhistoryCart();
}

class viewhistoryCart extends State<historycart> with TickerProviderStateMixin {
  late final TabController _tabController;
  final NotificationServices _services = NotificationServices();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> dialog(BuildContext context, String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text(
                "Thông báo",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.left,
              ),
              content: const Text(
                "Bạn có chắc chắn muốn hủy không ?",
                style: TextStyle(fontSize: 17),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Hủy"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 30),
                          backgroundColor: const Color(0xffff6900),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        setState(() {
                          updateCancel(id);
                          EasyLoading.showSuccess("Thành công");
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("Xác nhận"),
                    )
                  ],
                ),
              ]);
        });
  }

  void updateCancel(String id) async {
    final itemUser = Provider.of<getProflieUser>(context, listen: false);
    itemUser.fetchData();
    final firestore = FirebaseFirestore.instance;
    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
    await firestore
        .collection("User")
        .doc(itemUser.data[0]["key"])
        .collection("History")
        .doc(id)
        .set({"orderStatus": "Đã hủy","cancellationPeriod":formattedDate}, SetOptions(merge: true));
    _services.getDeviceToken().then((value) async {
      var data = {
        'to': value.toString(),
        'priority': 'high',
        'notification': {
          'title': "Thông báo",
          'body': "Bạn đã hủy đơn hàng thành công !"
        },
      };
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'key=AAAA8RSe39E:APA91bHHfagU3E9eknYgyQfdDbi4_UjBcm15mxNyUraAqNuA2foddBkxdYQkR_3u_HH8xyWeFx0MfHHzt_gjvTb1RfaVlj9LTQsLHGq13KMoNsXpe9wiM0aJhGHlY2DRll4N9vJiwvKT'
          });
    });
  }

  void updateReceive(String id) async {
    final itemUser = Provider.of<getProflieUser>(context, listen: false);
    itemUser.fetchData();
    final firestore = FirebaseFirestore.instance;
    firestore
        .collection("User")
        .doc(itemUser.data[0]["key"])
        .collection("History")
        .doc(id)
        .update({"orderStatus": "Đã nhận"});
    _services.getDeviceToken().then((value) async {
      var data = {
        'to': value.toString(),
        'priority': 'high',
        'notification': {
          'title': "Thông báo",
          'body': "Bạn đã nhận hàng thành công "
        },
        'data': {'id': '3'}
      };
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'key=AAAA8RSe39E:APA91bHHfagU3E9eknYgyQfdDbi4_UjBcm15mxNyUraAqNuA2foddBkxdYQkR_3u_HH8xyWeFx0MfHHzt_gjvTb1RfaVlj9LTQsLHGq13KMoNsXpe9wiM0aJhGHlY2DRll4N9vJiwvKT'
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<getOderUser>(context);
    final itemUser = Provider.of<getProflieUser>(context);
    itemUser.fetchData();
    if (itemUser.data.isNotEmpty) {
      item.fetchDataOder(itemUser.data[0]["key"]);
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
                    "Lịch sử mua hàng",
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
            TabBar(
              controller: _tabController,
              tabs: const [
                Text(
                  "Chờ xác nhận",
                  style:
                      TextStyle(fontFamily: "LibreBodoni-Medium", fontSize: 15),
                ),
                Text(
                  "Đang vận chuyển",
                  style:
                      TextStyle(fontFamily: "LibreBodoni-Medium", fontSize: 15),
                ),
                Text(
                  "Chờ giao hàng",
                  style:
                      TextStyle(fontFamily: "LibreBodoni-Medium", fontSize: 15),
                ),
                Text(
                  "Đã nhận",
                  style:
                      TextStyle(fontFamily: "LibreBodoni-Medium", fontSize: 15),
                ),
                Text(
                  "Đã hủy",
                  style:
                      TextStyle(fontFamily: "LibreBodoni-Medium", fontSize: 15),
                ),
              ],
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
            ),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: TabBarView(controller: _tabController, children: [
                Stack(children: [
                  ListView.builder(
                      itemCount: item.data.length,
                      itemBuilder: (context, index) {
                        final getIndex = item.data[index];
                        final getData = getIndex["data"];
                        final getKey = getIndex["key"];
                        if (getData["orderStatus"] == "Chờ xác nhận") {
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => informationProducst(data: getData),));
                            },
                            child: Card(
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              elevation: 5,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 170,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          margin: EdgeInsets.all(10),
                                          child: Image.network(
                                            getData["imageUrl"],
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          margin: const EdgeInsets.only(
                                              left: 10, top: 10, bottom: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              160,
                                                      child: Text(
                                                        getData["productName"],
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "LibreBaskerville-Regular"),
                                                      )),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    getData["price"] + "₫",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    160,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        getData["orderStatus"],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Color(0xff4158ff),
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                      Text(
                                                        "x" + getData["quantity"],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Color(0xff6D6D6D),
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ]),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          dialog(context, getKey);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 30),
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        child: Text(
                                          "Hủy",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily:
                                                  "LibreBodoni-MediumItalic",
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      }),
                  if (item.data.isEmpty ||
                      !item.data.any((getIndex) =>
                          getIndex["data"]["orderStatus"] == "Chờ xác nhận"))
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      top: 90,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/image/grocery-bag.png",
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Chưa có đơn hàng",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium",
                                fontSize: 18,
                                color: Color(0xff7d7d7d)),
                          )
                        ],
                      ),
                    )
                ]),
                Stack(children: [
                  ListView.builder(
                      itemCount: item.data.length,
                      itemBuilder: (context, index) {
                        final getIndex = item.data[index];
                        final getData = getIndex["data"];
                        if (getData["orderStatus"] == "Đang vận chuyển") {
                          return  InkWell(
                              onTap: (){
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => informationProducst(data: getData),));
                              },
                              child:Card(
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white)),
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        margin: EdgeInsets.all(10),
                                        child: Image.network(
                                          getData["imageUrl"],
                                        ),
                                      ),
                                      Container(
                                        height: 100,
                                        margin: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            160,
                                                    child: Text(
                                                      getData["productName"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily:
                                                              "LibreBaskerville-Regular"),
                                                    )),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  getData["price"] + "₫",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  160,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      getData["orderStatus"],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff00bdde),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "x" + getData["quantity"],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff6D6D6D),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ]),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                        }
                        return Container();
                      }),
                  if (item.data.isEmpty ||
                      !item.data.any((getIndex) =>
                          getIndex["data"]["orderStatus"] == "Đang vận chuyển"))
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      top: 90,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/image/grocery-bag.png",
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Chưa có đơn hàng",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium",
                                fontSize: 18,
                                color: Color(0xff7d7d7d)),
                          )
                        ],
                      ),
                    )
                ]),
                Stack(children: [
                  ListView.builder(
                      itemCount: item.data.length,
                      itemBuilder: (context, index) {
                        final getIndex = item.data[index];
                        final getData = getIndex["data"];
                        final getKey = getIndex["key"];
                        if (getData["orderStatus"] == "Đang giao hàng") {
                          return  InkWell(
                              onTap: (){
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => informationProducst(data: getData),));
                              },
                              child:Card(
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white)),
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 170,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        margin: EdgeInsets.all(10),
                                        child: Image.network(
                                          getData["imageUrl"],
                                        ),
                                      ),
                                      Container(
                                        height: 100,
                                        margin: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            160,
                                                    child: Text(
                                                      getData["productName"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily:
                                                              "LibreBaskerville-Regular"),
                                                    )),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  getData["price"] + "₫",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  160,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      getData["orderStatus"],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff01af72),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "x" + getData["quantity"],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff6D6D6D),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ]),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        updateReceive(getKey);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xffFF6900),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 30),
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10))),
                                      child: Text(
                                        "Đã nhận",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily:
                                            "LibreBodoni-MediumItalic",
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          );
                        }
                        return Container();
                      }),
                  if (item.data.isEmpty ||
                      !item.data.any((getIndex) =>
                          getIndex["data"]["orderStatus"] ==
                          "Đang giao hàng"))
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      top: 90,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/image/grocery-bag.png",
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Chưa có đơn hàng",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium",
                                fontSize: 18,
                                color: Color(0xff7d7d7d)),
                          )
                        ],
                      ),
                    )
                ]),
                Stack(children: [
                  ListView.builder(
                      itemCount: item.data.length,
                      itemBuilder: (context, index) {
                        final getIndex = item.data[index];
                        final getData = getIndex["data"];
                        final getKey = getData["productKey"];
                        if (getData["orderStatus"] == "Đã nhận") {
                          return InkWell(
                              onTap: (){
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => informationProducst(data: getData),));
                              },
                              child:Card(
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white)),
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 170,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        margin: EdgeInsets.all(10),
                                        child: Image.network(
                                          getData["imageUrl"],
                                        ),
                                      ),
                                      Container(
                                        height: 100,
                                        margin: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            160,
                                                    child: Text(
                                                      getData["productName"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily:
                                                              "LibreBaskerville-Regular"),
                                                    )),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  getData["price"] + "₫",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  160,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      getData["orderStatus"],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff11dc00),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "x" + getData["quantity"],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff6D6D6D),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ]),
                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => productReviews(Name: getData["productName"], Image: getData["imageUrl"],keyIdCa:getData["CategoriesId"],keyId:getKey,)),);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xffFF6900),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 30),
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10))),
                                      child: Text(
                                        "Đánh giá",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily:
                                            "LibreBodoni-MediumItalic",
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                              ));
                        }
                        return Container();
                      }),
                  if (item.data.isEmpty ||
                      !item.data.any((getIndex) =>
                          getIndex["data"]["orderStatus"] == "Đã nhận"))
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      top: 90,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/image/grocery-bag.png",
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Chưa có đơn hàng",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium",
                                fontSize: 18,
                                color: Color(0xff7d7d7d)),
                          )
                        ],
                      ),
                    )
                ]),
                Stack(children: [
                  ListView.builder(
                      itemCount: item.data.length,
                      itemBuilder: (context, index) {
                        final getIndex = item.data[index];
                        final getData = getIndex["data"];
                        if (getData["orderStatus"] == "Đã hủy") {
                          return InkWell(
                              onTap: (){
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => informationProducst(data: getData),));
                              },
                              child:Card(
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white)),
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        margin: EdgeInsets.all(10),
                                        child: Image.network(
                                          getData["imageUrl"],
                                        ),
                                      ),
                                      Container(
                                        height: 100,
                                        margin: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            160,
                                                    child: Text(
                                                      getData["productName"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily:
                                                              "LibreBaskerville-Regular"),
                                                    )),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  getData["price"] + "₫",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  160,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      getData["orderStatus"],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "x" + getData["quantity"],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff6D6D6D),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ]),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )),
                          );
                        }
                        return Container();
                      }),
                  if (item.data.isEmpty ||
                      !item.data.any((getIndex) =>
                          getIndex["data"]["orderStatus"] == "Đã hủy"))
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      top: 90,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/image/grocery-bag.png",
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Chưa có đơn hàng",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium",
                                fontSize: 18,
                                color: Color(0xff7d7d7d)),
                          )
                        ],
                      ),
                    )
                ]),
              ]),
            ))
          ],
        ),
      ),
    );
  }
}

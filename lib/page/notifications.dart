import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lab5/barNavigation.dart';
import 'package:lab5/cartItem/cart.dart';
import 'package:lab5/cartItem/informationProducst.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../changeNotifier/ProfileUser.dart';


class notifications extends StatefulWidget {
  const notifications({super.key});

  @override
  viewNotifications createState() => viewNotifications();
}
class viewNotifications extends State<notifications> {
  List<bool> showAllTextList = [];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData(){
    final itemNoti=Provider.of<getNotiUser>(context,listen: false);
    final itemUser = Provider.of<getProflieUser>(context,listen: false);
    itemUser.fetchData();
    if (itemUser.data.isNotEmpty) {
      itemNoti.fetchDataNoti(itemUser.data[0]["key"]);
      showAllTextList = List.filled(itemNoti.data.length, false);
    }
  }
  @override
  Widget build(BuildContext context) {
    final itemNoti=Provider.of<getNotiUser>(context);
    final itemUser = Provider.of<getProflieUser>(context);
    itemUser.fetchData();
    final itemCart=Provider.of<getCartUser>(context);
    if (itemUser.data.isNotEmpty) {
      itemNoti.fetchDataNoti(itemUser.data[0]["key"]);
      itemCart.fetchDataCart(itemUser.data[0]["key"]);
    }
    return Scaffold(
      body: SafeArea(
        child:  Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 15, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Thông báo",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "LibreBodoni-BoldItalic"),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10, right: 15),
                          child: badges.Badge(
                            badgeContent: Text(
                              itemCart.data.length.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            showBadge: true,
                            ignorePointer: false,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => const cart(),
                                      ));
                                },
                                child: const Icon(
                                  Icons.shopping_cart,
                                  size: 30,
                                )),
                          ))
                    ],
                  )),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 5,
                color: const Color(0xffe7e6e6),
              ),
              Expanded(child: SingleChildScrollView(child: Column(children: [ ListView.builder(
                  itemCount: itemNoti.data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final itemIndex =itemNoti.data[index];
                    final itemKey =itemIndex['key'];
                    final itemData=itemIndex['data'];
                    final showAllText = showAllTextList[index];
                    if(itemData["orderStatus"] == "Đang vận chuyển"){
                      return Card(
                        child: InkWell(
                          onTap: (){Navigator.push(context, CupertinoPageRoute(builder: (context) => informationProducst(data: itemData),));},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 20, left: 10),
                                width: 90,
                                height: 100,
                                child: Image.network(itemData['imageUrl']),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width - 140,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                    RichText(
                                        overflow: showAllText
                                            ? TextOverflow.visible
                                            : TextOverflow.ellipsis,
                                        maxLines: showAllText ? null : 3,text: TextSpan(
                                        children: [
                                          const TextSpan(
                                              text: "Đơn hàng  " ,style: TextStyle(color: Colors.black,fontFamily: "LibreBodoni-Medium")
                                          ),
                                          TextSpan(
                                              text: itemKey,style: const TextStyle(color: Colors.lightBlue,decoration: TextDecoration.underline,fontFamily: "LibreBodoni-Bold",decorationColor: Colors.lightBlue,decorationStyle: TextDecorationStyle.double)
                                          ),
                                          const TextSpan(
                                            text:
                                            " đã được xác chúng tôi xác nhận và đơn hàng đang được giao cho đơn vị vận chuyển .Quý khách hàng kiểm tra thông báo thường xuyên để cập nhật thông tin mới nhất .Xin cảm ơn !",
                                            style: TextStyle(
                                              fontFamily: "LibreBodoni-Medium",
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),

                                          ),
                                        ]
                                    ))
                                    ,
                                    TextButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            showAllTextList[index] = !showAllText;
                                          });
                                        },
                                        icon: showAllText
                                            ? Image.asset(
                                          "assets/image/minus (2).png",
                                          height: 15,
                                          width: 15,
                                        )
                                            : Image.asset(
                                          "assets/image/add (2).png",
                                          height: 15,
                                          width: 15,
                                        ),
                                        label: showAllText
                                            ? const Text("Ẩn bớt")
                                            : const Text("Xem thêm"))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else if(itemData["orderStatus"] == "Đã nhận") {
                      return Card(
                        child: InkWell(
                          onTap: (){Navigator.push(context, CupertinoPageRoute(builder: (context) => informationProducst(data: itemData),));},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 20, left: 10),
                                width: 90,
                                height: 100,
                                child: Image.network(itemData['imageUrl']),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width - 140,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                    RichText(
                                        overflow: showAllText
                                            ? TextOverflow.visible
                                            : TextOverflow.ellipsis,
                                        maxLines: showAllText ? null : 3,text: TextSpan(
                                        children: [
                                          const TextSpan(
                                              text: "Đơn hàng  " ,style: TextStyle(color: Colors.black,fontFamily: "LibreBodoni-Medium")
                                          ),
                                          TextSpan(
                                              text: itemKey,style: const TextStyle(color: Colors.lightBlue,decoration: TextDecoration.underline,fontFamily: "LibreBodoni-Bold",decorationColor: Colors.lightBlue,decorationStyle: TextDecorationStyle.double)
                                          ),
                                          const TextSpan(
                                            text:
                                            " đã được vận chuyển đến với khách hàng thành công . Cảm ơn quý khách hàng luôn tin tưởng và ủng hộ !",
                                            style: TextStyle(
                                              fontFamily: "LibreBodoni-Medium",
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),

                                          ),
                                        ]
                                    ))
                                    ,
                                    TextButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            showAllTextList[index] = !showAllText;
                                          });
                                        },
                                        icon: showAllText
                                            ? Image.asset(
                                          "assets/image/minus (2).png",
                                          height: 15,
                                          width: 15,
                                        )
                                            : Image.asset(
                                          "assets/image/add (2).png",
                                          height: 15,
                                          width: 15,
                                        ),
                                        label: showAllText
                                            ? const Text("Ẩn bớt")
                                            : const Text("Xem thêm"))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  }

              ),
                if (itemNoti.data.isEmpty)
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    top: 90,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/image/notification.png",
                          height: 150,
                          width: 150,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Chưa có thông báo mới nào ?",
                          style: TextStyle(
                              fontFamily: "LibreBodoni-Medium",
                              fontSize: 18,
                              color: Color(0xff7d7d7d)),
                        )
                      ],
                    ),
                  )],),))
            ],
          ),
        ),
    );
  }
}

class NotificationServices {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (kDebugMode) {
        print(event.notification!.title);
        print(event.notification!.body);
        print(event.data["key"]);
      }
      if (Platform.isAndroid) {
        initLocalNotification(context, event);
        showNotification(event);
      } else {
        showNotification(event);
      }
    });
  }

  void initLocalNotification(BuildContext context, RemoteMessage message) async {
    var androidInit = const AndroidInitializationSettings("@drawable/logo");
    var settings = InitializationSettings(android: androidInit);
    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessager(context, message);
      },
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      "Hi",
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: "your channel description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
      icon: "@drawable/logo",
    );

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    Future.delayed(Duration.zero, () {
      _notificationsPlugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void requestNotificationServices() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    } else {
    }
  }

  void setUpInteractMessenger(BuildContext context) async {
    RemoteMessage? initialMessenger = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessenger != null) {
      handleMessager(context, initialMessenger);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessager(context, event);
    });
  }

  void handleMessager(BuildContext context, RemoteMessage message) {
    if (message.data["id"] == 1) {
      final barNavigationState = context.findAncestorStateOfType<viewBar>();
      if (barNavigationState != null) {
        barNavigationState.changeTabToNotifications();
      }
    }
  }
}


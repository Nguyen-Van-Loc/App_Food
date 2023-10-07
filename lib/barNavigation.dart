import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab5/account/Login/login.dart';
import 'package:lab5/main.dart';

class viewBar extends State<barNavigation> {
  final _auth = FirebaseAuth.instance.currentUser;
  User? _user;

  Future<void> _checkAuthentication() async {
    User? user = _auth;
    setState(() {
      _user = user;
    });
  }

  String selectedIconButton = '';
  final List<Widget> screen = [home(), favorite(), profile(), notifications()];
  Widget currentScreen = home();

  @override
  void initState() {
    super.initState();
    selectedIconButton = 'trangchu';
    _checkAuthentication();
  }

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        bucket: _bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentScreen = home();
                        selectedIconButton = 'trangchu';
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.home,
                          color: selectedIconButton == 'trangchu'
                              ? Colors.red
                              : Colors.grey,
                        ),
                        Text(
                          "Trang chủ",
                          style: TextStyle(
                              color: selectedIconButton == 'trangchu'
                                  ? Colors.red
                                  : Colors.grey,
                              fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentScreen = favorite();
                        selectedIconButton = 'favorite';
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: selectedIconButton == 'favorite'
                              ? Colors.red
                              : Colors.grey,
                        ),
                        Text(
                          "Yêu thích",
                          style: TextStyle(
                              color: selectedIconButton == 'favorite'
                                  ? Colors.red
                                  : Colors.grey,
                              fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _user == null
                          ? Navigator.push(context,
                              CupertinoPageRoute(builder: (context) => login()))
                          : setState(() {
                              currentScreen = notifications();
                              selectedIconButton = 'notifications';
                            });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: selectedIconButton == 'notifications'
                              ? Colors.red
                              : Colors.grey,
                        ),
                        Text(
                          "Thông báo",
                          style: TextStyle(
                              color: selectedIconButton == 'notifications'
                                  ? Colors.red
                                  : Colors.grey,
                              fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentScreen = profile();
                        selectedIconButton = 'profile';
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person_sharp,
                          color: selectedIconButton == 'profile'
                              ? Colors.red
                              : Colors.grey,
                        ),
                        Text(
                          "Người dùng",
                          style: TextStyle(
                              color: selectedIconButton == 'profile'
                                  ? Colors.red
                                  : Colors.grey,
                              fontSize: 13),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

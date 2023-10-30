import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab5/account/Login/login.dart';
import 'package:lab5/changeNotifier/ProfileUser.dart';
import 'package:lab5/page/favorite.dart';
import 'package:lab5/page/home.dart';
import 'package:lab5/page/notifications.dart';
import 'package:lab5/page/profile.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
class barNavigation extends StatefulWidget {
  viewBar createState() => viewBar();
}
class viewBar extends State<barNavigation> {
  final _auth = FirebaseAuth.instance.currentUser;
  User? _user;

  Widget currentScreen = home();
  String selectedIconButton = 'trangchu';
  void changeTabToNotifications() {
    setState(() {
      currentScreen = notifications();
      selectedIconButton = 'notifications';
    });
  }
  final List<Widget> screens = [home(), favorite(), profile(), notifications()];
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }
  Future<void> _checkAuthentication() async {
    User? user = _auth;
    setState(() {
      _user = user;
    });
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
                _buildNavigationBarItem(
                  Icons.home,
                  'Trang chủ',
                  'trangchu',
                  home(),
                ),
                _buildNavigationBarItem(
                  Icons.favorite,
                  'Yêu thích',
                  'favorite',
                  favorite(),
                ),
                _buildNavigationBarItem(
                  Icons.notifications_active,
                  'Thông báo',
                  'notifications',
                  notifications(),
                ),
                _buildNavigationBarItem(
                  Icons.person_sharp,
                  'Người dùng',
                  'profile',
                  profile(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationBarItem(
      IconData icon, String label, String itemKey, Widget screen) {
    Widget iconWidget;
    final itemNoti=Provider.of<getNotiUser>(context);
    final itemUser = Provider.of<getProflieUser>(context);
    itemUser.fetchData();
    if (itemUser.data.isNotEmpty) {
      itemNoti.fetchDataNoti(itemUser.data[0]["key"]);
    }
    if (itemKey == 'notifications') {
      // Use the Badge widget for the "Notifications" icon
      iconWidget = badges.Badge(
        badgeContent: Text(
          itemNoti.data.length.toString(),
          style: TextStyle(color: Colors.white),
        ),
        showBadge: true,
        child: Icon(
          icon,
          color: selectedIconButton == itemKey ? Colors.red : Colors.grey,
          size: 30,
        ),
      );
    } else {
      iconWidget = Icon(
        icon,
        color: selectedIconButton == itemKey ? Colors.red : Colors.grey,
      );
    }
    return InkWell(
      onTap: () {
        setState(() {
          if (_user == null && itemKey != 'trangchu') {
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => login()));
          } else {
            currentScreen = screen;
            selectedIconButton = itemKey;
          }
        });
      },
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget,
            Text(
              label,
              style: TextStyle(
                color: selectedIconButton == itemKey ? Colors.red : Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
    );
  }
}

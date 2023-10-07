import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lab5/barNavigation.dart';
import 'package:lab5/cartItem/cart.dart';
import 'package:lab5/page/home.dart';
import 'package:lab5/page/favorite.dart';
import 'package:lab5/page/menu.dart';
import 'package:lab5/page/profile.dart';
import 'package:lab5/page/notifications.dart';
import 'package:lab5/splash.dart';
import 'package:provider/provider.dart';
import 'User/user.dart';
import 'cartItem/addressPay.dart';
import 'cartItem/historyCart.dart';
import 'cartItem/payProduct.dart';
import 'cartItem/productdetails.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => getProflieUser(),
    child: MyApp(),
  ));
  configLoading();
}

class getProflieUser extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _data = [];

  List<Map<String, dynamic>> get data => _data;

  Future<void> fetchData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final email = user.email;
        final querySnapshot = await _firestore
            .collection('User')
            .where('email', isEqualTo: email)
            .get();

        _data = querySnapshot.docs.map((doc) {
          final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          final String key = doc.id;
          return {"key": key, "data": data};
        }).toList();

        notifyListeners();
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu từ Firestore: $e');
    }
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: barNavigation(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}

class splacsh extends StatefulWidget {
  viewSplash createState() => viewSplash();
}

class barNavigation extends StatefulWidget {
  viewBar createState() => viewBar();
}

class home extends StatefulWidget {
  viewHome createState() => viewHome();
}

class favorite extends StatefulWidget {
  viewFavorite createState() => viewFavorite();
}

class profile extends StatefulWidget {
  viewProfile createState() => viewProfile();
}

class notifications extends StatefulWidget {
  viewNotifications createState() => viewNotifications();
}

class menu extends StatefulWidget {
  viewMenu createState() => viewMenu();
}

class cart extends StatefulWidget {
  viewCart createState() => viewCart();
}

class historycart extends StatefulWidget {
  viewhistoryCart createState() => viewhistoryCart();
}

class user extends StatefulWidget {
  viewUser createState() => viewUser();
}

class productDetails extends StatefulWidget {
  viewproductDetails createState() => viewproductDetails();
}

class payProduct extends StatefulWidget {
  viewpayProduct createState() => viewpayProduct();
}

class addressPay extends StatefulWidget {
  viewaddressPay createState() => viewaddressPay();
}

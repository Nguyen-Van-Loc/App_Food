import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lab5/page/notifications.dart';
import 'package:lab5/splash.dart';
import 'package:provider/provider.dart';
import 'changeNotifier/Categories.dart';
import 'changeNotifier/ProfileUser.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>getProflieUser()),
    ChangeNotifierProvider(create: (_)=>getProducts()),
    ChangeNotifierProvider(create: (_)=>getCategories()),
    ChangeNotifierProvider(create: (_)=>getCartUser()),
    ChangeNotifierProvider(create: (_)=>getOderUser()),
    ChangeNotifierProvider(create: (_)=>categoryProducts()),
    ChangeNotifierProvider(create: (_)=>getFavouriteUser()),
    ChangeNotifierProvider(create: (_)=>getNotiUser())
  ],child: const MyApp(),));
  configLoading();
  FirebaseMessaging.onBackgroundMessage(firebaseMessegerBackground);

}
Future<void> firebaseMessegerBackground(RemoteMessage message)async{
  await Firebase.initializeApp();
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
    ..userInteractions = false
    ..dismissOnTap = false
    ..toastPosition =EasyLoadingToastPosition.bottom;
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  final NotificationServices _services = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _services.requestNotificationServices();
    _services.firebaseInit(context);
    _services.getDeviceToken().then((value) {
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Splacsh(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}























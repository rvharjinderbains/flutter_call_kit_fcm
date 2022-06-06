import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:superbrains/handler/push_notification_handler.dart';
import 'package:superbrains/ui/ui_home_page.dart';
import 'package:superbrains/ui/ui_splash_page.dart';

import 'handler/call_handler.dart';
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationHandler().init();
  await CallHandler().init();

  String? token = await FirebaseMessaging.instance.getToken();
  DatabaseReference database = FirebaseDatabase.instance.reference();

  String? key = database.child("token").push().key;
  Map<String, dynamic> childUpdates = HashMap();
  childUpdates["/token/" + key!] = token;
  database.update(childUpdates);



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}

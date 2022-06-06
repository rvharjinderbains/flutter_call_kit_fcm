import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superbrains/ui/ui_home_page.dart';
import 'package:superbrains/ui/ui_notification_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();

    bool isFromNotification = prefs.getBool("is_from_notification") ?? false;

    print("isFromNotification $isFromNotification");

    Timer(const Duration(seconds: 3), () async {
      if (isFromNotification) {
        await prefs.setBool("is_from_notification", false);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const NotificationPage()));
      } else {

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(
                      title: 'Title',
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}

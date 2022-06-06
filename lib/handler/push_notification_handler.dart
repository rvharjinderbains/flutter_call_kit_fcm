import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superbrains/handler/call_handler.dart';
import 'package:superbrains/main.dart';
import 'package:superbrains/ui/ui_notification_page.dart';
import 'package:uuid/uuid.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.data}");
  // final prefs = await SharedPreferences.getInstance();
  // await prefs.setBool("is_from_notification", true);
  if (message.data["notification_type"] == "0") {
    CallHandler().showCallkitIncoming(const Uuid().v4(), message);
  }
}

class PushNotificationHandler {
  final _firebaseMessaging = FirebaseMessaging.instance;

  init() async {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) async {
      _handleNotificationData(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) async{
      print('onMessageOpenedApp data: ${event.data}');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("is_from_notification", true);
      navigateToScreen(message: event);
    });

    _firebaseMessaging.getToken().then((value) => print('FCM Token: $value'));
  }

  _handleNotificationData(message) {
    if (message.data["notification_type"] == "0") {
      CallHandler().showCallkitIncoming(const Uuid().v4(), message);
    } else if (message.data["notification_type"] == "1") {
      _createNotification(message);
    }
  }

  _createNotification(message) async {
    var notification = message.data;
    print("Notification Data from onMessage" +
        message.notification!.title.toString());
    print("Notification");
    print(message.data);

    var androids = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = const IOSInitializationSettings();
    var platform = InitializationSettings(android: androids, iOS: ios);

    late AndroidNotificationChannel channel;
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(platform,
        onSelectNotification: (String? data) async {
      print("onSelectNotification data $data");
      navigateToScreen(message: message);
    });

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    var random = Random();
    int id1 = random.nextInt(900000) + 100000;
    await flutterLocalNotificationsPlugin.show(id1, message.notification!.title,
        message.notification!.body, platformChannelSpecifics,
        payload: jsonEncode(notification));
  }

  navigateToScreen({RemoteMessage? message}) async {
    print("under navigateToScreen ");
    print("under  " + message!.data.toString());
    if (message != null) {
      switch (message.data["notification_type"]) {
        case "1":
          print("under  1");

          Navigator.push(
              navigatorKey.currentState!.context,
              MaterialPageRoute(
                  builder: (context) => const NotificationPage()));
          break;
        default:
          print("under  default");

        // do things here
      }
    }
  }
}

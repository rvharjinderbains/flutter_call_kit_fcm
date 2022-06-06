import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:superbrains/ui/ui_notification_page.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String? _currentUuid;

  @override
  void initState() {
    super.initState();
    handleNotifcationMessage();
  }

  handleNotifcationMessage() {
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    //   print("onMessageOpenedApp: $message");
    //   Navigator.push(navigatorKey.currentState!.context,
    //       MaterialPageRoute(builder: (context) => const NotificationPage()));
    // });
  }



  void _incrementCounter() {
    startCall();
    setState(() {
      _counter++;
    });
  }

  startCall() async {
    _currentUuid = const Uuid().v4();
    var params = <String, dynamic>{
      'id': _currentUuid,
      'nameCaller': 'Hien Nguyen',
      'handle': '0123456789',
      'type': 1,
      'extra': <String, dynamic>{'userId': '1a2b3c4d'},
      'ios': <String, dynamic>{'handleType': 'generic'}
    };
    await FlutterCallkitIncoming.startCall(params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

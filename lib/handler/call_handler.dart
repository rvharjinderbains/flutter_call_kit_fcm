import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:superbrains/model/caller_notification_model.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';
import '../ui/ui_notification_page.dart';

class CallHandler {
  RemoteMessage? remoteMessage;
  String? _currentUuid;

  CallerNotificationModel? model;

  init() {
    _currentUuid = const Uuid().v4();
    callingEventListeners();
  }

  callingEventListeners() {
    FlutterCallkitIncoming.onEvent.listen((event) {
      switch (event!.name) {
        case CallEvent.ACTION_CALL_INCOMING:
          // TODO: received an incoming
          // model = CallerNotificationModel.fromJson(jsonDecode(event.body));

          print("ACTION_CALL_INCOMING " + event.body.toString());
          showMissedCallNotification(event.body);
          break;
        case CallEvent.ACTION_CALL_START:
          // TODO: started an outgoing call
          // TODO: show screen calling in Flutter
          // model = CallerNotificationModel.fromJson(jsonDecode(event.body));
          print("ACTION_CALL_START " + event.body.toString());

          // showOutGoingCallNotification(event.body);
          showOutgoingCall();
          break;
        case CallEvent.ACTION_CALL_ACCEPT:
          // TODO: accepted an incoming call
          // TODO: show screen calling in Flutter
          print("ACTION_CALL_ACCEPT " + event.body.toString());
          navigateToScreen(event.body);

          break;
        case CallEvent.ACTION_CALL_DECLINE:
          // TODO: declined an incoming call
          print("ACTION_CALL_DECLINE " + event.body.toString());

          break;
        case CallEvent.ACTION_CALL_ENDED:
          // TODO: ended an incoming/outgoing call
          break;
        case CallEvent.ACTION_CALL_TIMEOUT:
          // TODO: missed an incoming call
          print("ACTION_CALL_TIMEOUT " + event.body.toString());

          break;
        case CallEvent.ACTION_CALL_CALLBACK:
          // TODO: only Android - click action `Call back` from missed call notification
          print("ACTION_CALL_CALLBACK " + event.body.toString());

          break;
        case CallEvent.ACTION_CALL_TOGGLE_HOLD:
          print("ACTION_CALL_TOGGLE_HOLD " + event.body.toString());

          // TODO: only iOS
          break;
        case CallEvent.ACTION_CALL_TOGGLE_MUTE:
          // TODO: only iOS
          print("ACTION_CALL_TOGGLE_MUTE " + event.body.toString());

          break;
        case CallEvent.ACTION_CALL_TOGGLE_DMTF:
          // TODO: only
          print("ACTION_CALL_TOGGLE_DMTF " + event.body.toString());

          break;
        case CallEvent.ACTION_CALL_TOGGLE_GROUP:
          // TODO: only iOS
          print("ACTION_CALL_TOGGLE_GROUP " + event.body.toString());

          break;
        case CallEvent.ACTION_CALL_TOGGLE_AUDIO_SESSION:
          // TODO: only iOS
          print("ACTION_CALL_TOGGLE_AUDIO_SESSION " + event.body.toString());

          break;
        case CallEvent.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
          // TODO: only iOS
          print("ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP " +
              event.body.toString());

          break;
      }
    });
  }

  Future<void> showOutgoingCall() async {
    await FlutterCallkitIncoming.activeCalls();
  }

  Future<void> showCallkitIncoming(String uuid, RemoteMessage modelData) async {
    remoteMessage = modelData;
    _currentUuid = uuid;

    var params = <String, dynamic>{
      'id': uuid,
      'nameCaller': modelData.data["nameCaller"],
      'appName': modelData.data["appName"],
      'avatar': modelData.data["avatar"],
      'handle': modelData.data["handle"],
      'type': 0,
      'duration': 30000,
      'textAccept': 'Accept',
      'textDecline': 'Decline',
      'textMissedCall': 'Missed call',
      'textCallback': 'Call back',
      'extra': <String, dynamic>{'userId': '1a2b3c4d'},
      'headers': <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      'android': <String, dynamic>{
        'isCustomNotification': true,
        'isShowLogo': false,
        'isShowCallback': false,
        'ringtonePath': 'system_ringtone_default',
        'backgroundColor': '#0955fa',
        'background': 'https://i.pravatar.cc/500',
        'actionColor': '#4CAF50'
      },
      'ios': <String, dynamic>{
        'iconName': 'CallKitLogo',
        'handleType': '',
        'supportsVideo': true,
        'maximumCallGroups': 2,
        'maximumCallsPerCallGroup': 1,
        'audioSessionMode': 'default',
        'audioSessionActive': true,
        'audioSessionPreferredSampleRate': 44100.0,
        'audioSessionPreferredIOBufferDuration': 0.005,
        'supportsDTMF': true,
        'supportsHolding': true,
        'supportsGrouping': false,
        'supportsUngrouping': false,
        'ringtonePath': 'system_ringtone_default'
      }
    };
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

  showMissedCallNotification(Map<String, dynamic> data) async {
    _currentUuid = const Uuid().v4();
    var params = <String, dynamic>{
      'id': _currentUuid,
      'nameCaller': data["nameCaller"],
      'handle': data["handle"],
      'type': 1,
      'textMissedCall': 'Missed call',
      'textCallback': 'Call back',
      'extra': <String, dynamic>{'userId': data["extra"]["userId"]},
    };
    await FlutterCallkitIncoming.showMissCallNotification(params);
  }

  showOutGoingCallNotification(Map<String, dynamic> data
      // CallerNotificationModel modelData
      ) async {
    _currentUuid = const Uuid().v4();
    var params = <String, dynamic>{
      'id': _currentUuid,
      'nameCaller': data["nameCaller"],
      'handle': data["handle"],
      'type': 1,
      'extra': <String, dynamic>{'userId': data["extra"]["userId"]},
      'ios': <String, dynamic>{
        'handleType': data["ios"] != null
            ? data["ios"]["handleType"] ?? "generic"
            : "generic"
      } //generic
    };
    await FlutterCallkitIncoming.startCall(params);
  }

  showEndCallNotification() async {
    var params = <String, dynamic>{'id': _currentUuid};
    await FlutterCallkitIncoming.endCall(params);
  }

  navigateToScreen(data) async {
    print("under navigateToScreen ");
    print("under  " + data!.toString());

    Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (context) => const NotificationPage()));
    return;
    if (data != null) {
      switch (data["notification_type"]) {
        case "0":
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

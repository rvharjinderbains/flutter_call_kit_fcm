// To parse this JSON data, do
//
//     final callerNotificationModel = callerNotificationModelFromJson(jsonString);

import 'dart:convert';

CallerNotificationModel callerNotificationModelFromJson(String str) => CallerNotificationModel.fromJson(json.decode(str));

String callerNotificationModelToJson(CallerNotificationModel data) => json.encode(data.toJson());

class CallerNotificationModel {
  CallerNotificationModel({
    this.id,
    this.nameCaller,
    this.appName,
    this.avatar,
    this.handle,
    this.type,
    this.duration,
    this.textAccept,
    this.textDecline,
    this.textMissedCall,
    this.textCallback,
    this.extra,
    this.headers,
    this.android,
    this.ios,
  });

  String? id;
  String? nameCaller;
  String? appName;
  String? avatar;
  String? handle;
  int? type;
  int? duration;
  String? textAccept;
  String? textDecline;
  String? textMissedCall;
  String? textCallback;
  Extra? extra;
  Headers? headers;
  Android? android;
  Ios? ios;

  factory CallerNotificationModel.fromJson(Map<String, dynamic> json) => CallerNotificationModel(
    id: json["id"],
    nameCaller: json["nameCaller"],
    appName: json["appName"],
    avatar: json["avatar"],
    handle: json["handle"],
    type: json["type"],
    duration: json["duration"],
    textAccept: json["textAccept"],
    textDecline: json["textDecline"],
    textMissedCall: json["textMissedCall"],
    textCallback: json["textCallback"],
    extra: Extra.fromJson(json["extra"]),
    headers: Headers.fromJson(json["headers"]),
    android: Android.fromJson(json["android"]),
    ios: Ios.fromJson(json["ios"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nameCaller": nameCaller,
    "appName": appName,
    "avatar": avatar,
    "handle": handle,
    "type": type,
    "duration": duration,
    "textAccept": textAccept,
    "textDecline": textDecline,
    "textMissedCall": textMissedCall,
    "textCallback": textCallback,
    "extra": extra!.toJson(),
    "headers": headers!.toJson(),
    "android": android!.toJson(),
    "ios": ios!.toJson(),
  };
}

class Android {
  Android({
    this.isCustomNotification,
    this.isShowLogo,
    this.isShowCallback,
    this.ringtonePath,
    this.backgroundColor,
    this.background,
    this.actionColor,
  });

  bool? isCustomNotification;
  bool? isShowLogo;
  bool? isShowCallback;
  String? ringtonePath;
  String? backgroundColor;
  String? background;
  String? actionColor;

  factory Android.fromJson(Map<String, dynamic> json) => Android(
    isCustomNotification: json["isCustomNotification"],
    isShowLogo: json["isShowLogo"],
    isShowCallback: json["isShowCallback"],
    ringtonePath: json["ringtonePath"],
    backgroundColor: json["backgroundColor"],
    background: json["background"],
    actionColor: json["actionColor"],
  );

  Map<String, dynamic> toJson() => {
    "isCustomNotification": isCustomNotification,
    "isShowLogo": isShowLogo,
    "isShowCallback": isShowCallback,
    "ringtonePath": ringtonePath,
    "backgroundColor": backgroundColor,
    "background": background,
    "actionColor": actionColor,
  };
}

class Extra {
  Extra({
    this.userId,
  });

  String? userId;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
  };
}

class Headers {
  Headers({
    this.apiKey,
    this.platform,
  });

  String? apiKey;
  String? platform;

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
    apiKey: json["apiKey"],
    platform: json["platform"],
  );

  Map<String, dynamic> toJson() => {
    "apiKey": apiKey,
    "platform": platform,
  };
}

class Ios {
  Ios({
    this.iconName,
    this.handleType,
    this.supportsVideo,
    this.maximumCallGroups,
    this.maximumCallsPerCallGroup,
    this.audioSessionMode,
    this.audioSessionActive,
    this.audioSessionPreferredSampleRate,
    this.audioSessionPreferredIoBufferDuration,
    this.supportsDtmf,
    this.supportsHolding,
    this.supportsGrouping,
    this.supportsUngrouping,
    this.ringtonePath,
  });

  String? iconName;
  String? handleType;
  bool? supportsVideo;
  int? maximumCallGroups;
  int? maximumCallsPerCallGroup;
  String? audioSessionMode;
  bool? audioSessionActive;
  int? audioSessionPreferredSampleRate;
  double? audioSessionPreferredIoBufferDuration;
  bool? supportsDtmf;
  bool? supportsHolding;
  bool? supportsGrouping;
  bool? supportsUngrouping;
  String? ringtonePath;

  factory Ios.fromJson(Map<String, dynamic> json) => Ios(
    iconName: json["iconName"],
    handleType: json["handleType"],
    supportsVideo: json["supportsVideo"],
    maximumCallGroups: json["maximumCallGroups"],
    maximumCallsPerCallGroup: json["maximumCallsPerCallGroup"],
    audioSessionMode: json["audioSessionMode"],
    audioSessionActive: json["audioSessionActive"],
    audioSessionPreferredSampleRate: json["audioSessionPreferredSampleRate"],
    audioSessionPreferredIoBufferDuration: json["audioSessionPreferredIOBufferDuration"].toDouble(),
    supportsDtmf: json["supportsDTMF"],
    supportsHolding: json["supportsHolding"],
    supportsGrouping: json["supportsGrouping"],
    supportsUngrouping: json["supportsUngrouping"],
    ringtonePath: json["ringtonePath"],
  );

  Map<String, dynamic> toJson() => {
    "iconName": iconName,
    "handleType": handleType,
    "supportsVideo": supportsVideo,
    "maximumCallGroups": maximumCallGroups,
    "maximumCallsPerCallGroup": maximumCallsPerCallGroup,
    "audioSessionMode": audioSessionMode,
    "audioSessionActive": audioSessionActive,
    "audioSessionPreferredSampleRate": audioSessionPreferredSampleRate,
    "audioSessionPreferredIOBufferDuration": audioSessionPreferredIoBufferDuration,
    "supportsDTMF": supportsDtmf,
    "supportsHolding": supportsHolding,
    "supportsGrouping": supportsGrouping,
    "supportsUngrouping": supportsUngrouping,
    "ringtonePath": ringtonePath,
  };
}

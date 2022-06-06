// To parse this JSON data, do
//
//     final pushNotificationModel = pushNotificationModelFromJson(jsonString);

import 'dart:convert';

PushNotificationModel pushNotificationModelFromJson(String str) =>
    PushNotificationModel.fromJson(json.decode(str));

String pushNotificationModelToJson(PushNotificationModel data) =>
    json.encode(data.toJson());

class PushNotificationModel {
  PushNotificationModel({
    this.data,
  });

  Data? data;

  factory PushNotificationModel.fromJson(Map<String, dynamic> json) =>
      PushNotificationModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.type,
    this.udid,
    this.nameCaller,
    this.appName,
    this.avatar,
    this.handle,
  });

  String? type;
  String? udid;
  String? nameCaller;
  String? appName;
  String? avatar;
  String? handle;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        udid: json["udid"],
        nameCaller: json["nameCaller"],
        appName: json["appName"],
        avatar: json["avatar"],
        handle: json["handle"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "udid": udid,
        "nameCaller": nameCaller,
        "appName": appName,
        "avatar": avatar,
        "handle": handle,
      };
}

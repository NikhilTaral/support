// To parse this JSON data, do
//
//     final ticketClassificationActionResponsetModel = ticketClassificationActionResponsetModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TicketClassificationActionResponsetModel
    ticketClassificationActionResponsetModelFromJson(String str) =>
        TicketClassificationActionResponsetModel.fromJson(json.decode(str));

String ticketClassificationActionResponsetModelToJson(
        TicketClassificationActionResponsetModel data) =>
    json.encode(data.toJson());

class TicketClassificationActionResponsetModel {
  final Data data;
  final bool success;
  final int failCode;
  final Params params;
  final String message;

  TicketClassificationActionResponsetModel({
    required this.data,
    required this.success,
    required this.failCode,
    required this.params,
    required this.message,
  });

  TicketClassificationActionResponsetModel copyWith({
    Data? data,
    bool? success,
    int? failCode,
    Params? params,
    String? message,
  }) =>
      TicketClassificationActionResponsetModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        params: params ?? this.params,
        message: message ?? this.message,
      );

  factory TicketClassificationActionResponsetModel.fromJson(
          Map<String, dynamic> json) =>
      TicketClassificationActionResponsetModel(
        data: Data.fromJson(json["data"]),
        success: json["success"],
        failCode: json["failCode"],
        params: Params.fromJson(json["params"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "success": success,
        "failCode": failCode,
        "params": params.toJson(),
        "message": message,
      };
}

class Data {
  final String message;

  Data({
    required this.message,
  });

  Data copyWith({
    String? message,
  }) =>
      Data(
        message: message ?? this.message,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}

class Params {
  Params();

  Params copyWith() => Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}

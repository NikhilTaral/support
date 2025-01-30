import 'dart:convert';

TicketClassificationActionResponsetModel
    ticketClassificationActionResponsetModelFromJson(String str) =>
        TicketClassificationActionResponsetModel.fromJson(json.decode(str));

String ticketClassificationActionResponsetModelToJson(
        TicketClassificationActionResponsetModel data) =>
    json.encode(data.toJson());

class TicketClassificationActionResponsetModel {
  Data? data;
  bool? success;
  num? failCode;
  String? message;

  TicketClassificationActionResponsetModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  factory TicketClassificationActionResponsetModel.fromJson(
          Map<String, dynamic> json) =>
      TicketClassificationActionResponsetModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
        failCode: json["failCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "success": success,
        "failCode": failCode,
        "message": message,
      };
}

class Data {
  String? message;

  Data({
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}

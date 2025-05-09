import 'dart:convert';

AiAccuracyAndValidationTrendsResponseModel aiAccuracyAndValidationTrendsResponseModelFromJson(String str) =>
    AiAccuracyAndValidationTrendsResponseModel.fromJson(json.decode(str));

String aiAccuracyAndValidationTrendsResponseModelToJson(AiAccuracyAndValidationTrendsResponseModel data) =>
    json.encode(data.toJson());

class AiAccuracyAndValidationTrendsResponseModel {
  final Data? data;
  final bool? success;
  final num? failCode;
  final String? message;

  AiAccuracyAndValidationTrendsResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  AiAccuracyAndValidationTrendsResponseModel copyWith({
    Data? data,
    bool? success,
    num? failCode,
    String? message,
  }) =>
      AiAccuracyAndValidationTrendsResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
      );

  factory AiAccuracyAndValidationTrendsResponseModel.fromJson(Map<String, dynamic> json) =>
      AiAccuracyAndValidationTrendsResponseModel(
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
  final List<Item>? items;

  Data({
    this.items,
  });

  Data copyWith({
    List<Item>? items,
  }) =>
      Data(
        items: items ?? this.items,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  final String? date;
  final num? aiAccuracy;
  final num? validationPercentage;
  final num? aIClosedTicketsPercentage;

  Item({
    this.date,
    this.aiAccuracy,
    this.validationPercentage,
    this.aIClosedTicketsPercentage
  });

  Item copyWith({
    String? date,
    num? aiAccuracy,
    num? validationPercentage,
  }) =>
      Item(
        date: date ?? this.date,
        aiAccuracy: aiAccuracy ?? this.aiAccuracy,
        validationPercentage: validationPercentage ?? this.validationPercentage,
        aIClosedTicketsPercentage: aIClosedTicketsPercentage?? this.aIClosedTicketsPercentage
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        date: json["date"] ?? "",
        aiAccuracy: json["aiAccuracy"]?.toDouble(),
        validationPercentage: json["validationPercentage"]?.toDouble(),
        aIClosedTicketsPercentage: json["AIClosedTicketsPercentage"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "aiAccuracy": aiAccuracy,
        "validationPercentage": validationPercentage,
        "AIClosedTicketsPercentage":aIClosedTicketsPercentage
      };
}

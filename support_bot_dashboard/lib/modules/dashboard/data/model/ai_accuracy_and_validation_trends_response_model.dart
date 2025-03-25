import 'dart:convert';

AiAccuracyAndValidationTrendsResponseModel
    aiAccuracyAndValidationTrendsResponseModelFromJson(String str) =>
        AiAccuracyAndValidationTrendsResponseModel.fromJson(json.decode(str));

String aiAccuracyAndValidationTrendsResponseModelToJson(
        AiAccuracyAndValidationTrendsResponseModel data) =>
    json.encode(data.toJson());

class AiAccuracyAndValidationTrendsResponseModel {
  final List<GraphData>? data;
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
    List<GraphData>? data,
    bool? success,
    int? failCode,
    String? message,
  }) =>
      AiAccuracyAndValidationTrendsResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
      );

  factory AiAccuracyAndValidationTrendsResponseModel.fromJson(
          Map<String, dynamic> json) =>
      AiAccuracyAndValidationTrendsResponseModel(
        data: json["data"] == null
            ? []
            : List<GraphData>.from(
                json["data"]!.map((x) => GraphData.fromJson(x))),
        success: json["success"],
        failCode: json["failCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
        "failCode": failCode,
        "message": message,
      };
}

class GraphData {
  final String? date;
  final double? aiAccuracy;
  final num? validationPercentage;

  GraphData({
    this.date,
    this.aiAccuracy,
    this.validationPercentage,
  });

  GraphData copyWith({
    String? date,
    double? aiAccuracy,
    num? validationPercentage,
  }) =>
      GraphData(
        date: date ?? this.date,
        aiAccuracy: aiAccuracy ?? this.aiAccuracy,
        validationPercentage: validationPercentage ?? this.validationPercentage,
      );

  factory GraphData.fromJson(Map<String, dynamic> json) => GraphData(
        date: json["date"],
        aiAccuracy: json["aiAccuracy"]?.toDouble(),
        validationPercentage: json["validationPercentage"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "aiAccuracy": aiAccuracy,
        "validationPercentage": validationPercentage,
      };
}

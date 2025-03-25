import 'dart:convert';

class AiAccuracyAndValidationTrendsRequestModel {
  final String? startDate;
  final String? endDate;
  final List<Filter>? filter;

  AiAccuracyAndValidationTrendsRequestModel({
    this.startDate,
    this.endDate,
    this.filter,
  });

  factory AiAccuracyAndValidationTrendsRequestModel.fromRawJson(String str) =>
      AiAccuracyAndValidationTrendsRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AiAccuracyAndValidationTrendsRequestModel.fromJson(
          Map<String, dynamic> json) =>
      AiAccuracyAndValidationTrendsRequestModel(
        startDate: json["startDate"],
        endDate: json["endDate"],
        filter: json["filter"] == null
            ? []
            : List<Filter>.from(json["filter"]!.map((x) => Filter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate??"",
        "endDate": endDate??"",
        "filter": filter == null
            ? []
            : List<dynamic>.from(filter!.map((x) => x.toJson())),
      };
}

class Filter {
  final String? fieldName;
  final List<String>? fieldValue;

  Filter({
    this.fieldName,
    this.fieldValue,
  });

  factory Filter.fromRawJson(String str) => Filter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        fieldName: json["fieldName"],
        fieldValue: json["fieldValue"] == null
            ? []
            : List<String>.from(json["fieldValue"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "fieldName": fieldName,
        "fieldValue": fieldValue == null
            ? []
            : List<dynamic>.from(fieldValue!.map((x) => x)),
      };
}

import 'dart:convert';

import 'package:support_bot_dashboard/modules/ticket_classification/data/model/get_all_validation_users_request_model.dart';

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
            : List<Filter>.from(json["filter"]?.map((x) => Filter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate??"",
        "endDate": endDate??"",
        "filter": filter == null
            ? []
            : List<dynamic>.from(filter!.map((x) => x.toJson())),
      };
}

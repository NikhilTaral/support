import 'dart:convert';

import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_request_model.dart';

class DashboardExportRequestModel {
  final DateTime? startDate;
  final DateTime? endDate;
  final List<Filter>? filter;
  final num? page;
  final String? ticketId;
  final num? pageSize;

  DashboardExportRequestModel({
    this.startDate,
    this.endDate,
    this.filter,
    this.page,
    this.ticketId,
    this.pageSize,
  });

  DashboardExportRequestModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
    List<Filter>? filter,
    num? page,
    String? ticketId,
    num? pageSize,
  }) =>
      DashboardExportRequestModel(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        filter: filter ?? this.filter,
        page: page ?? this.page,
        ticketId: ticketId ?? this.ticketId,
        pageSize: pageSize ?? this.pageSize,
      );

  factory DashboardExportRequestModel.fromRawJson(String str) =>
      DashboardExportRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DashboardExportRequestModel.fromJson(Map<String, dynamic> json) =>
      DashboardExportRequestModel(
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        filter: json["filter"] == null
            ? []
            : List<Filter>.from(json["filter"]!.map((x) => Filter.fromJson(x))),
        page: json["page"],
        ticketId: json["ticketId"],
        pageSize: json["pageSize"],
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "filter": filter == null
            ? []
            : List<dynamic>.from(filter!.map((x) => x.toJson())),
        "page": page,
        "ticketId": ticketId,
        "pageSize": pageSize,
      };
}

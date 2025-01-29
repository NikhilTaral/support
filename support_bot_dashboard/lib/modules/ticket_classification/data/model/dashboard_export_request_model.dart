import 'dart:convert';

class DashboardExportRequestModel {
    final DateTime? startDate;
    final DateTime? endDate;
    final List<Filter>? filter;
    final num? page;
    final num? pageSize;

    DashboardExportRequestModel({
        this.startDate,
        this.endDate,
        this.filter,
        this.page,
        this.pageSize,
    });

    DashboardExportRequestModel copyWith({
        DateTime? startDate,
        DateTime? endDate,
        List<Filter>? filter,
        num? page,
        num? pageSize,
    }) => 
        DashboardExportRequestModel(
            startDate: startDate ?? this.startDate,
            endDate: endDate ?? this.endDate,
            filter: filter ?? this.filter,
            page: page ?? this.page,
            pageSize: pageSize ?? this.pageSize,
        );

    factory DashboardExportRequestModel.fromRawJson(String str) => DashboardExportRequestModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DashboardExportRequestModel.fromJson(Map<String, dynamic> json) => DashboardExportRequestModel(
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        filter: json["filter"] == null ? [] : List<Filter>.from(json["filter"]!.map((x) => Filter.fromJson(x))),
        page: json["page"],
        pageSize: json["pageSize"],
    );

    Map<String, dynamic> toJson() => {
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "filter": filter == null ? [] : List<dynamic>.from(filter!.map((x) => x.toJson())),
        "page": page,
        "pageSize": pageSize,
    };
}

class Filter {
    final String? fieldName;
    final List<String>? fieldValue;

    Filter({
        this.fieldName,
        this.fieldValue,
    });

    Filter copyWith({
        String? fieldName,
        List<String>? fieldValue,
    }) => 
        Filter(
            fieldName: fieldName ?? this.fieldName,
            fieldValue: fieldValue ?? this.fieldValue,
        );

    factory Filter.fromRawJson(String str) => Filter.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        fieldName: json["fieldName"],
        fieldValue: json["fieldValue"] == null ? [] : List<String>.from(json["fieldValue"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "fieldName": fieldName,
        "fieldValue": fieldValue == null ? [] : List<dynamic>.from(fieldValue!.map((x) => x)),
    };
}

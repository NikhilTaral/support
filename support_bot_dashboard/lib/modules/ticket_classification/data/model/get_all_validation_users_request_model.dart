import 'dart:convert';

class GetAllValidationUsersRequestModel {
  final DateTime? startDate;
  final DateTime? endDate;
  final List<Filter>? filter;

  GetAllValidationUsersRequestModel({
    this.startDate,
    this.endDate,
    this.filter,
  });

  GetAllValidationUsersRequestModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
    List<Filter>? filter,
  }) =>
      GetAllValidationUsersRequestModel(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        filter: filter ?? this.filter,
      );

  factory GetAllValidationUsersRequestModel.fromRawJson(String str) =>
      GetAllValidationUsersRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllValidationUsersRequestModel.fromJson(
          Map<String, dynamic> json) =>
      GetAllValidationUsersRequestModel(
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        filter: json["filter"] == null
            ? []
            : List<Filter>.from(json["filter"]!.map((x) => Filter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "filter": filter == null
            ? []
            : List<dynamic>.from(filter?.map((x) => x.toJson()) ?? []),
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

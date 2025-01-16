import 'dart:convert';

class TicketClassificationRequestModel {
  DateTime startDate;
  DateTime endDate;
  List<Filter> filter;

  TicketClassificationRequestModel({
    required this.startDate,
    required this.endDate,
    required this.filter,
  });

  TicketClassificationRequestModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
    List<Filter>? filter,
  }) =>
      TicketClassificationRequestModel(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        filter: filter ?? this.filter,
      );

  factory TicketClassificationRequestModel.fromRawJson(String str) =>
      TicketClassificationRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TicketClassificationRequestModel.fromJson(
          Map<String, dynamic> json) =>
      TicketClassificationRequestModel(
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        filter:
            List<Filter>.from(json["filter"].map((x) => Filter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "filter": List<dynamic>.from(filter.map((x) => x.toJson()))
      };
}

class Filter {
  String fieldName;
  List<String> fieldValue;

  Filter({
    required this.fieldName,
    required this.fieldValue,
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
        fieldValue: List<String>.from(json["fieldValue"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "fieldName": fieldName,
        "fieldValue": List<dynamic>.from(fieldValue.map((x) => x))
      };
}

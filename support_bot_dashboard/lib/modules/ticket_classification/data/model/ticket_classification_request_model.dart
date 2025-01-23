import 'dart:convert';

class TicketClassificationRequestModel {
  DateTime? startDate;
  DateTime endDate;
  List<Filter> filter;
  final String? ticketId;
  final num? page;
  final num? pageSize;

  TicketClassificationRequestModel(
      {required this.startDate,
      required this.endDate,
      this.ticketId,
      required this.filter,
      this.page,
      this.pageSize});

  TicketClassificationRequestModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
    List<Filter>? filter,
    final num? page,
    final String? ticketId,
    final num? pageSize,
  }) =>
      TicketClassificationRequestModel(
          startDate: startDate ?? this.startDate,
          endDate: endDate ?? this.endDate,
          filter: filter ?? this.filter,
          ticketId: ticketId ?? this.ticketId,
          page: page ?? this.page,
          pageSize: page ?? this.pageSize);

  factory TicketClassificationRequestModel.fromRawJson(String str) =>
      TicketClassificationRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TicketClassificationRequestModel.fromJson(
          Map<String, dynamic> json) =>
      TicketClassificationRequestModel(
          startDate: DateTime.parse(json["startDate"]),
          endDate: DateTime.parse(json["endDate"]),
          ticketId: json["ticketId"],
          filter:
              List<Filter>.from(json["filter"].map((x) => Filter.fromJson(x))),
          page: json['page'],
          pageSize: json['pageSize']);

  Map<String, dynamic> toJson() => {
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "filter": List<dynamic>.from(filter.map((x) => x.toJson())),
        'page': page,
        'ticketId': ticketId,
        'pageSize': pageSize
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

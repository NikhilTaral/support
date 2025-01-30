import 'dart:convert';

class TicketClassificationActionEntitietModel {
  final Data? data;
  final bool? success;
  final num? failCode;
  final Params? params;
  final String? message;

  TicketClassificationActionEntitietModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  TicketClassificationActionEntitietModel copyWith({
    Data? data,
    bool? success,
    num? failCode,
    Params? params,
    String? message,
  }) =>
      TicketClassificationActionEntitietModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        params: params ?? this.params,
        message: message ?? this.message,
      );
}

class Data {
  final String? message;

  Data({
    this.message,
  });

  Data copyWith({
    String? message,
  }) =>
      Data(
        message: message ?? this.message,
      );
}

class Params {
  Params();

  Params copyWith() => Params();

  factory Params.fromRawJson(String str) => Params.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}

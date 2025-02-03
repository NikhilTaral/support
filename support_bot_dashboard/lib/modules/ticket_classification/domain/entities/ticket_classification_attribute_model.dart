import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_response_model.dart';

class TicketClassificationAttributeModel {
  final Data? data;
  final bool? success;
  final num? failCode;

  final String? message;

  TicketClassificationAttributeModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  TicketClassificationAttributeModel copyWith({
    Data? data,
    bool? success,
    num? failCode,
    String? message,
  }) =>
      TicketClassificationAttributeModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
      );
}

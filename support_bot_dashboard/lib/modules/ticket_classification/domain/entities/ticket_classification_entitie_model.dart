import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_response_model.dart';

class TicketClassificationEntitieModel {
  final Data? data;
  final bool? success;
  final num? failCode;

  final String? message;

  TicketClassificationEntitieModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  TicketClassificationEntitieModel copyWith({
    Data? data,
    bool? success,
    num? failCode,
    String? message,
  }) =>
      TicketClassificationEntitieModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
      );
}

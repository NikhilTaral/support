part of 'ticket_classification_bloc.dart';

abstract class TicketClassificationEvent {}

class TicketClassificationDataCallEvent extends TicketClassificationEvent {
  final String? fieldName;
  final DateTime? startDate;
  final DateTime? endDate;
  final num? page;
  final num? pageSize;

  final List<String>? fieldValue;

  TicketClassificationDataCallEvent(
      {this.fieldName,
      required this.startDate,
      required this.endDate,
      this.fieldValue,
      this.page,
      this.pageSize});
}

class RevertClassificationEvent extends TicketClassificationEvent {
  final String? ticketId;

  RevertClassificationEvent({this.ticketId});
}

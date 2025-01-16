part of 'ticket_classification_bloc.dart';

abstract class TicketClassificationEvent {}

class TicketClassificationDataCallEvent extends TicketClassificationEvent {
  final String? fieldName;

  final List<String>? fieldValue;

  TicketClassificationDataCallEvent({this.fieldName, this.fieldValue});
}

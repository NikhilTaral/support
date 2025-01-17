part of 'ticket_classification_action_bloc.dart';

abstract class TicketClassificationActionEvent {}

class TicketClassificationActionOnEvent
    extends TicketClassificationActionEvent {
  final String? ticketId;
  final String? pipelineId;
  final String? classification;
  TicketClassificationActionOnEvent(
      {this.ticketId, this.pipelineId, this.classification});
}

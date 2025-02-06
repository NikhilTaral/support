part of 'ticket_classification_action_bloc.dart';

abstract class TicketClassificationActionEvent {}

class RevertClassificationEvent extends TicketClassificationActionEvent {
  final String? ticketId;

  RevertClassificationEvent({this.ticketId});
}

class UpdateClassificationEvent extends TicketClassificationActionEvent {
  final String? ticketId;
  final String? pipelineId;
  final String? classification;
  UpdateClassificationEvent({this.classification,this.pipelineId,this.ticketId});
}

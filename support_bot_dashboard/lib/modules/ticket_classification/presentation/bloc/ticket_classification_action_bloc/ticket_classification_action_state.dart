part of 'ticket_classification_action_bloc.dart';

abstract class TicketClassificationActionState {}

class TicketClassificationActionIntialState
    extends TicketClassificationActionState {}

class TicketClassificationActionLoadingState
    extends TicketClassificationActionState {}

class TicketClassificationActionSucssesState
    extends TicketClassificationActionState {
  final TicketClassificationActionEntitietModel?
      ticketClassificationActionEntitietModel;
  TicketClassificationActionSucssesState(
      {this.ticketClassificationActionEntitietModel});
}

class TicketClassificationActionFailureState
    extends TicketClassificationActionState {}

class TicketClassificationActionEmptyState
    extends TicketClassificationActionState {}

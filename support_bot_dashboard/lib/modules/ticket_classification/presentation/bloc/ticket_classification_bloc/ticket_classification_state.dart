part of 'ticket_classification_bloc.dart';

abstract class TicketClassificationState {}

class TicketClassificationIntialState extends TicketClassificationState {}

class TicketClassificationLoadingState extends TicketClassificationState {}

class TicketClassificationSucssesState extends TicketClassificationState {
  final TicketClassificationEntitieModel? model;
  TicketClassificationSucssesState({this.model});
}

class TicketClassificationFailureState extends TicketClassificationState {}
class TicketClassificationEmptyState extends TicketClassificationState{}
part of 'ticket_classification_bloc.dart';

abstract class TicketClassificationState {}

class TicketClassificationIntialState extends TicketClassificationState {}

class TicketClassificationLoadingState extends TicketClassificationState {}

class TicketClassificationSucssesState extends TicketClassificationState {
  final TicketClassificationEntitieModel? model;
  final DateTime? startDate;
  final DateTime? endDate;

  TicketClassificationSucssesState({
    this.model,
    this.startDate,
    this.endDate,
  });
}

class TicketClassificationFailureState extends TicketClassificationState {}

class TicketClassificationEmptyState extends TicketClassificationState {}

part of 'ticket_classification_bloc.dart';

abstract class TicketClassificationState {}

class TicketClassificationIntialState extends TicketClassificationState {}

class TicketClassificationLoadingState extends TicketClassificationState {}

class TicketClassificationSucssesState extends TicketClassificationState {
  final TicketClassificationEntitieModel? model;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String> pipelineId;
  final num? currentIndex;
  final Map<String, dynamic>? currentRowData;

  TicketClassificationSucssesState({
    this.model,
    this.startDate,
    this.endDate,
    this.pipelineId = const [],
    this.currentIndex,
    this.currentRowData,
  });
}

class TicketClassificationFailureState extends TicketClassificationState {}

class TicketClassificationEmptyState extends TicketClassificationState {}


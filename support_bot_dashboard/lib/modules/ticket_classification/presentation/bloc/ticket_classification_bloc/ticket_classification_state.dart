part of 'ticket_classification_bloc.dart';

abstract class TicketClassificationState {}

class TicketClassificationIntialState extends TicketClassificationState {}

class TicketClassificationLoadingState extends TicketClassificationState {}

class TicketClassificationSuccessState extends TicketClassificationState {
  final TicketClassificationAttributeModel? ticketClassificationAttributeModel;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String> pipelineId;
  final num? currentIndex;
  final Map<String, dynamic>? currentRowData;
  final String? selectedClassification;
  final String? id;
  final List<String>? pipelineIds;
  final String? reason;
  final String? selectedClassificationValue;

  TicketClassificationSuccessState({
    this.ticketClassificationAttributeModel,
    this.startDate,
    this.endDate,
    this.pipelineId = const [],
    this.currentIndex,
    this.currentRowData,
    this.selectedClassification,
    this.id,
    this.pipelineIds,
    this.reason,
    this.selectedClassificationValue,
  });
  TicketClassificationSuccessState copyWith({String? selectedClassification}) {
    return TicketClassificationSuccessState(
      selectedClassification:
          selectedClassification ?? this.selectedClassification,
    );
  }
}

class TicketClassificationFailureState extends TicketClassificationState {}

class TicketClassificationEmptyState extends TicketClassificationState {
  final String? message;

  TicketClassificationEmptyState({this.message});
}

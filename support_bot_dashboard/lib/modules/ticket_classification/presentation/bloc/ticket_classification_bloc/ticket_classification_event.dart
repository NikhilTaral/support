part of 'ticket_classification_bloc.dart';

abstract class TicketClassificationEvent {}

class TicketClassificationDataCallEvent extends TicketClassificationEvent {
  final String? fieldName;
  final DateTime? startDate;
  final DateTime? endDate;
  final num? page;
  final String? ticketId;
  final num? pageSize;
  final String? fieldValue;
  final String? selectedBOPsState;
  final String? selectedClassification;
  final String? selectedValidation;
  final String? selectedPipelineId;

  TicketClassificationDataCallEvent(
      {this.fieldName,
      this.startDate,
      this.endDate,
      this.ticketId,
      this.selectedBOPsState,
      this.selectedClassification,
      this.selectedValidation,
      this.selectedPipelineId,
      this.fieldValue,
      this.page,
      this.pageSize});
}

class TicketClassificationPreviousDataEvent extends TicketClassificationEvent {}

class TicketClassificationNextDataEvent extends TicketClassificationEvent {}

class UpdateTheClassificationEvent extends TicketClassificationEvent {
  final String? classification;

  UpdateTheClassificationEvent({this.classification});
}

class SaveChangeValidationEvent extends TicketClassificationEvent {

  final String? id;
  final List<String>? pipelineIds;
  final String? reason;
  final String? selectedClassification;
  SaveChangeValidationEvent(
      {
      this.id,
      this.pipelineIds,
      this.reason,
      this.selectedClassification});
}

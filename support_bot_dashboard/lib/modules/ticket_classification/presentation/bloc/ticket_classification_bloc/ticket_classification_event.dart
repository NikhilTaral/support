part of 'ticket_classification_bloc.dart';

abstract class TicketClassificationEvent {}

class TicketClassificationDataCallEvent extends TicketClassificationEvent {
  final String? fieldName;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? page;
  final String? ticketId;
  final num? pageSize;
  final List<String>? fieldValue;
  final String? selectedBOPsState;
  final String? selectedClassification;
  final String? selectedValidation;
  final String? selectedPipelineId;

  TicketClassificationDataCallEvent(
      {this.fieldName,
      required this.startDate,
      required this.endDate,
      this.ticketId,
      this.selectedBOPsState,
      this.selectedClassification,
      this.selectedValidation,
      this.selectedPipelineId,
      this.fieldValue,
      this.page,
      this.pageSize});
}

class RevertClassificationEvent extends TicketClassificationEvent {
  final String? ticketId;

  RevertClassificationEvent({this.ticketId});
}

class TicketClassificationPreviousDataEvent extends TicketClassificationEvent {}

class TicketClassificationNextDataEvent extends TicketClassificationEvent {}

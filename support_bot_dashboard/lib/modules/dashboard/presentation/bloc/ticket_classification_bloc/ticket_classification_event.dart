part of 'ticket_classification_bloc.dart';

abstract class TicketClassificationEvent {}

class TickiteClassificationEvent extends TicketClassificationEvent {
  final List<String>? selectedPipelineValue;
  final String? fieldName;
  final DateTime? startDate ;
  final DateTime? endDate;
  TickiteClassificationEvent(
      {this.fieldName,
      this.startDate,
      this.endDate,
      this.selectedPipelineValue});
}

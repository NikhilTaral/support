part of 'ticket_classification_bloc.dart';

abstract class TicketClassificationEvent {}

class TickiteClassificationEvent extends TicketClassificationEvent {
  final List<String>? selectedPipelineValue;
  final String? fieldName;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  TickiteClassificationEvent(
      {this.fieldName,
      this.selectedDate,
      this.selectedMonth,
      this.selectedPipelineValue});
}

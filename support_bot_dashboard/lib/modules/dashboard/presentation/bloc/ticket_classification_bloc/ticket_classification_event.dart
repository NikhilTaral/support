part of 'ticket_classification_bloc.dart';

abstract class TicketClassificationEvent {}

class TickiteClassificationEvent extends TicketClassificationEvent {
  final String? selectedPipelineValue;
  final String? fildName;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  TickiteClassificationEvent(
      {this.fildName,
      this.selectedDate,
      this.selectedMonth,
      this.selectedPipelineValue});
}

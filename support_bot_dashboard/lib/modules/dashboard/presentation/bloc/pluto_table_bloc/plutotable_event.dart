part of 'plutotable_bloc.dart';

abstract class PlutotableEvent {}

class FetchTableDataEvent extends PlutotableEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;

  FetchTableDataEvent(
      {this.selectedDate, this.selectedMonth});
}

class SelectDateEvent extends PlutotableEvent {
  final DateTime selectedDate;

  SelectDateEvent({required this.selectedDate});
}

class SelectMonthEvent extends PlutotableEvent {
  final DateTime selectedMonth;

  SelectMonthEvent({required this.selectedMonth});
}

class UpdateValidationEvent extends PlutotableEvent {
  final String id;
  final String validation;
  final String reason;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;

  UpdateValidationEvent(
      { this.selectedDate,
       this.selectedMonth,
      required this.id,
      required this.validation,
      required this.reason});
}

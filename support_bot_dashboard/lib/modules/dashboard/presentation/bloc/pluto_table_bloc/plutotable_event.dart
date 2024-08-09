part of 'plutotable_bloc.dart';

abstract class PlutotableEvent {}

class FetchTableDataEvent extends PlutotableEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;

  FetchTableDataEvent({this.selectedDate, this.selectedMonth});
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
      {this.selectedDate,
      this.selectedMonth,
      required this.id,
      required this.validation,
      required this.reason});
}

class SelectClassificationEvent extends PlutotableEvent {
  final String selectedClassification;

  SelectClassificationEvent({required this.selectedClassification});
}

class FilterClassificationEvent extends PlutotableEvent {
  final String selectedClassification;
  final String selectedClassificationValidation;
  final DateTime selectedDate;
  final DateTime selectedMonth;

  FilterClassificationEvent(
      this.selectedDate,
      this.selectedMonth,
      this.selectedClassification,
      this.selectedClassificationValidation);
}

class FilterValidationEvent extends PlutotableEvent {
  final String selectedClassificationValidation;
  final String selectedClassification;
  final DateTime selectedDate;
  final DateTime selectedMonth;

  FilterValidationEvent(this.selectedClassificationValidation,
      this.selectedDate, this.selectedMonth, this.selectedClassification);
}

class CustomSidebarLoadRowData extends PlutotableEvent {
  final int rowIndex;

  CustomSidebarLoadRowData(this.rowIndex);
}

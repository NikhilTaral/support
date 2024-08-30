part of 'plutotable_bloc.dart';

abstract class PlutotableEvent {}

class FetchTableDataEvent extends PlutotableEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? selectedClassification;
  final String? selectedClassificationValidation;
  final String? selectedPipeline;

  FetchTableDataEvent(
      {this.selectedClassification,
      this.selectedClassificationValidation,
      this.selectedDate,
      this.selectedMonth,
      this.selectedPipeline});
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

class SelectPipelineEvent extends PlutotableEvent {
  final String selectedPipeline;

  SelectPipelineEvent({required this.selectedPipeline});
}

class FilterClassificationEvent extends PlutotableEvent {
  final String selectedClassification;
  final String selectedClassificationValidation;
  final DateTime selectedDate;
  final DateTime selectedMonth;

  FilterClassificationEvent(this.selectedDate, this.selectedMonth,
      this.selectedClassification, this.selectedClassificationValidation);
}

class FilterValidationEvent extends PlutotableEvent {
  final String selectedClassificationValidation;
  final String selectedClassification;
  final DateTime selectedDate;
  final DateTime selectedMonth;

  FilterValidationEvent(this.selectedClassificationValidation,
      this.selectedDate, this.selectedMonth, this.selectedClassification);
}

// class FilterPipelineEvent extends PlutotableEvent {
//   final DateTime selectedDate;
//   final DateTime selectedMonth;
//   final String selectedPipeline;

//   FilterPipelineEvent(
//       this.selectedDate, this.selectedMonth, this.selectedPipeline);
// }

class CustomSidebarLoadRowData extends PlutotableEvent {
  final int rowIndex;

  CustomSidebarLoadRowData(this.rowIndex);
}

class RevertClassificationEvent extends PlutotableEvent {
  final DateTime selectedDate;
  final DateTime selectedMonth;
   final String selectedClassification;
  String ticketId;
  RevertClassificationEvent({required this.selectedDate,required this.selectedMonth, required this.ticketId, required this.selectedClassification});
}
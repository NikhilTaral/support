part of 'plutotable_bloc.dart';

abstract class PlutotableEvent {}

class FetchTableDataEvent extends PlutotableEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? selectedClassification;
  final String? selectedClassificationValidation;
  final String? selectedPipeline;
  final String? ticketId;

  FetchTableDataEvent(
      {this.selectedClassification,
      this.selectedClassificationValidation,
      this.selectedDate,
      this.selectedMonth,
      this.selectedPipeline, this.ticketId});
}

class SelectDateEvent extends PlutotableEvent {
  final DateTime selectedDate;
  final String? selectedPipeline;

  SelectDateEvent({required this.selectedDate, required this.selectedPipeline});
}

class SelectMonthEvent extends PlutotableEvent {
  final DateTime selectedMonth;
   final String? selectedPipeline;

  SelectMonthEvent({required this.selectedMonth, this.selectedPipeline});
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
    final String pipeline;
    final String? ticketId;
  final String selectedClassificationValidation;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;


  FilterClassificationEvent(this.selectedDate, this.selectedMonth,
      this.selectedClassification, this.selectedClassificationValidation,this.pipeline, this.ticketId);
}

class FilterValidationEvent extends PlutotableEvent {
  final String selectedClassificationValidation;
  final String selectedClassification;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
    final String? pipeline;
    final String? ticketId;

  FilterValidationEvent(this.selectedClassificationValidation,
      this.selectedDate, this.selectedMonth, this.selectedClassification, this.pipeline, this.ticketId);
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
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
   final String selectedClassification;
  final String? ticketId;
  RevertClassificationEvent({required this.selectedDate,required this.selectedMonth, required this.ticketId, required this.selectedClassification});
}

class SearchTableEvent extends PlutotableEvent{
  final DateTime? selectDate;
  final DateTime? selectMonth;
  final String? classification;
  final String? classificationValidation;
  final String? pipeline;
  final String? ticketId;

  SearchTableEvent({required this.selectDate, required this.selectMonth, required this.ticketId,  this.pipeline,  this.classification,  this.classificationValidation});
}
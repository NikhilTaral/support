part of 'plutotable_bloc.dart';

abstract class PlutotableEvent {}

class FetchTableDataEvent extends PlutotableEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? selectedClassification;
  final String? selectedClassificationValidation;
  final String? selectedPipeline;
  final String? ticketId;
  final num? page;
  final num? pageSize;

  FetchTableDataEvent(
      {this.selectedClassification,
      this.selectedClassificationValidation,
      this.selectedDate,
      this.selectedMonth,
      this.selectedPipeline,
      this.ticketId,
      this.page,
      this.pageSize});
}

class SelectDateEvent extends PlutotableEvent {
  final DateTime selectedDate;
  final String? selectedPipeline;
    final num? page;
  final num? pageSize;

  SelectDateEvent({required this.selectedDate, required this.selectedPipeline,required this.page, required this.pageSize});
}

class SelectMonthEvent extends PlutotableEvent {
  final DateTime selectedMonth;
  final String? selectedPipeline;
    final num? page;
  final num? pageSize;

  SelectMonthEvent({required this.selectedMonth, this.selectedPipeline, required this.page, required this.pageSize});
}

class UpdateValidationEvent extends PlutotableEvent {
  final String id;
  final String validation;
  final String reason;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String pipeline;
  final String? classification;

  UpdateValidationEvent(
      {this.selectedDate,
      this.selectedMonth,
      required this.id,
      required this.pipeline,
      required this.validation,
      required this.reason,
      this.classification
      });
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
  final String? pipeline;
  final String? ticketId;
  final String? selectedClassificationValidation;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final num? page;
  final num? pageSize;

  FilterClassificationEvent(
      this.selectedDate,
      this.selectedMonth,
      this.selectedClassification,
      this.selectedClassificationValidation,
      this.pipeline,
      this.ticketId,
      this.page,
      this.pageSize);
}

class FilterValidationEvent extends PlutotableEvent {
  final String selectedClassificationValidation;
  final String selectedClassification;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? pipeline;
  final String? ticketId;
  final num? page;
  final num? pageSize;

  FilterValidationEvent(
      this.selectedClassificationValidation,
      this.selectedDate,
      this.selectedMonth,
      this.selectedClassification,
      this.pipeline,
      this.ticketId,
      this.page,
      this.pageSize);
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
  RevertClassificationEvent(
      {required this.selectedDate,
      required this.selectedMonth,
      required this.ticketId,
      required this.selectedClassification});
}

class UnRevertClassificationEvent extends PlutotableEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String selectedClassification;
  final String? ticketId;
  UnRevertClassificationEvent(
      {required this.selectedDate,
      required this.selectedMonth,
      required this.ticketId,
      required this.selectedClassification});
}

class SearchTableEvent extends PlutotableEvent {
  final DateTime? selectDate;
  final DateTime? selectMonth;
  final String? classification;
  final String? classificationValidation;
  final String? pipeline;
  final String? ticketId;
  final num? page;
  final num? pageSize;

  SearchTableEvent(
      {required this.selectDate,
      required this.selectMonth,
      required this.ticketId,
      this.pipeline,
      this.classification,
      this.classificationValidation,
      this.page,
      this.pageSize});
}

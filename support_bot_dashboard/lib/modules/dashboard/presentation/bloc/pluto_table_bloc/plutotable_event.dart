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

class GetValidationDetailsEvent extends PlutotableEvent{
  final String? ticketId;
  final DateTime? selectDate;
  final DateTime? selectMonth;
  final String? pipeline;

  GetValidationDetailsEvent({required this.ticketId, this.selectDate, this.selectMonth, this.pipeline});
}
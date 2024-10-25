part of 'export_bloc.dart';

abstract class ExportEvent {}

class FetchExportDataEvent extends ExportEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? selectedClassification;
  final String? selectedClassificationValidation;
  final String? selectedPipeline;
  final String? ticketId;

  FetchExportDataEvent(
      {this.selectedDate,
      this.selectedMonth,
      this.selectedClassification,
      this.selectedClassificationValidation,
      this.selectedPipeline,
      this.ticketId});
}

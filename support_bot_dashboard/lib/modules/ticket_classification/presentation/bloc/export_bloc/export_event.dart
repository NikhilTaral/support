part of 'export_bloc.dart';

abstract class ExportEvent {}

class FetchExportDataEvent extends ExportEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? selectedClassification;
  final String? bopsState;
  final String? selectedClassificationValidation;
  final String? selectedPipeline;
  final String? ticketId;

  FetchExportDataEvent(
      {this.startDate,
      this.endDate,
      this.selectedClassification,
      this.bopsState,
      this.selectedClassificationValidation,
      this.selectedPipeline,
      this.ticketId});
}

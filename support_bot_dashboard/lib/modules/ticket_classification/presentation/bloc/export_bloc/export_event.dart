part of 'export_bloc.dart';

abstract class ExportEvent {}

class FetchExportDataEvent extends ExportEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? selectedClassification;
  final String? classificationValidatedBy;
  final String? bopsState;
  final String? selectedClassificationValidation;
  final String? selectedPipeline;
  final String? ticketId;
  final List<String>? selectedPipelineId;
  final num? page;
  final num? pageSize;

  FetchExportDataEvent(
      {this.startDate,
      this.endDate,
      this.selectedClassification,
      this.classificationValidatedBy,
      this.bopsState,
      this.selectedClassificationValidation,
      this.selectedPipeline,
      this.ticketId,
      this.selectedPipelineId,
      this.page,
      this.pageSize});
}

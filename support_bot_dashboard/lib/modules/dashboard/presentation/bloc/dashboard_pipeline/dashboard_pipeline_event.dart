part of 'dashboard_pipeline_bloc.dart';

abstract class DashboardPipelineEvent{}

class FilterPipelineEvent extends DashboardPipelineEvent {
  final DateTime selectedDate;
  final DateTime selectedMonth;
  final String selectedPipeline;

  FilterPipelineEvent(
      this.selectedDate, this.selectedMonth, this.selectedPipeline);
}

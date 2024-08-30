part of 'dashboard_pipeline_bloc.dart';

abstract class DashboardPipelineState {}

class DashboardPipelineInitial extends DashboardPipelineState{}

class DashboardPipelineLoading extends DashboardPipelineState{}

class DashboardPipelineSuccess extends DashboardPipelineState{
  final DashboardPipelineAttributeModel dashboardPipelineAttributeModel;
  final String selectedPipelineValue;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;

  DashboardPipelineSuccess({required this.dashboardPipelineAttributeModel,required this.selectedPipelineValue, required this.selectedDate, required this.selectedMonth});
}

class DashboardPipelineFailure extends DashboardPipelineState{
  final String message;

  DashboardPipelineFailure({required this.message});
}
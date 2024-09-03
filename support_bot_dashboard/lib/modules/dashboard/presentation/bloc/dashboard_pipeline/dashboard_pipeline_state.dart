part of 'dashboard_pipeline_bloc.dart';

abstract class DashboardPipelineState {}

class DashboardPipelineInitial extends DashboardPipelineState{}

class DashboardPipelineLoading extends DashboardPipelineState{}

class DashboardPipelineSuccess extends DashboardPipelineState{
  final DashboardPipelineAttributeModel? dashboardPipelineAttributeModel;
  final String? selectedPipelineValue;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
    final int? index;
       bool? isDropdownEnabled = true;

  DashboardPipelineSuccess({ this.dashboardPipelineAttributeModel, this.selectedPipelineValue,  this.selectedDate,  this.selectedMonth, this.index,this.isDropdownEnabled, String? pipelineName});
}

class DashboardPipelineFailure extends DashboardPipelineState{
  final String message;

  DashboardPipelineFailure({required this.message});
}

class UpdatePipeline extends DashboardPipelineState{
  final String? pipeline;

  UpdatePipeline({required this.pipeline});
}
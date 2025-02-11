part of 'pipeline_tile_bloc.dart';

abstract class PipelineTileEvent {}

class PipelineTileInitialEvent extends PipelineTileEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  PipelineTileInitialEvent({
    this.startDate,
    this.endDate,
  });
}

class TogglePipelineChartVisibilityEvent extends PipelineTileEvent {}

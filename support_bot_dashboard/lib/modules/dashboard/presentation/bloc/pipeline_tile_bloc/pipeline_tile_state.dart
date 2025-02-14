part of 'pipeline_tile_bloc.dart';

abstract class PipelineTileState {}

class PipelineTileInitialState extends PipelineTileState {}

class PipelineTileLoadingState extends PipelineTileState {}

class PipelineTileEmptyState extends PipelineTileState {}

class PipelineTileFailureState extends PipelineTileState {}

class PipelineTileSuccessState extends PipelineTileState {
  final PipelineTileAttributeModel? pipelineTileAttributeModel;

  PipelineTileSuccessState({
    this.pipelineTileAttributeModel,
  });

  PipelineTileSuccessState copyWith({
    PipelineTileAttributeModel? pipelineTileAttributeModel,
  }) {
    return PipelineTileSuccessState(
      pipelineTileAttributeModel:
          pipelineTileAttributeModel ?? this.pipelineTileAttributeModel,
    );
  }
}

class TogglePipelineChartVisibilityState extends PipelineTileSuccessState {
  final bool isVisible;

  TogglePipelineChartVisibilityState(
      {this.isVisible = false, super.pipelineTileAttributeModel});
}

part of 'pipeline_tile_bloc.dart';

abstract class PipelineTileState {}

class PipelineTileInitialState extends PipelineTileState {}

class PipelineTileLoadingState extends PipelineTileState {}

class PipelineTileEmptyState extends PipelineTileState {}

class PipelineTileFailureState extends PipelineTileState {}

class PipelineTileSuccessState extends PipelineTileState {
  final PipelineTileAttributeModel? pipelineTileAttributeModel;
  final bool isChartVisible;

  PipelineTileSuccessState({
    this.pipelineTileAttributeModel,
    this.isChartVisible = false,
  });

  PipelineTileSuccessState copyWith({
    PipelineTileAttributeModel? pipelineTileAttributeModel,
    bool? isChartVisible,
  }) {
    return PipelineTileSuccessState(
      pipelineTileAttributeModel:
          pipelineTileAttributeModel ?? this.pipelineTileAttributeModel,
      isChartVisible: isChartVisible ?? this.isChartVisible,
    );
  }
}

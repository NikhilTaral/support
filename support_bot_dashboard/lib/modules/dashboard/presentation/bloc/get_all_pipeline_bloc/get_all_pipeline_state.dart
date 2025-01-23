part of 'get_all_pipeline_bloc.dart';

abstract class GetAllPipelineState {}

class GetAllPipelineInitialState extends GetAllPipelineState {}

class GetAllPipelineLoadingState extends GetAllPipelineState {}

class GetAllAllPipelineSuccessState extends GetAllPipelineState {
  final GetAllPipelinesAttributeModel? attributeModel;
  GetAllAllPipelineSuccessState({this.attributeModel});
}

class GetAllPipelineFailureState extends GetAllPipelineState {}

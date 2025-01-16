part of 'get_all_pipelines_bloc.dart';

abstract class GetAllPipelinesState {}

class GetAllPipelinesInitialState extends GetAllPipelinesState {}

class GetAllPipelinesLoadingState extends GetAllPipelinesState {}

class GetAllAllPipelinesSuccessState extends GetAllPipelinesState {
  final GetAllPipelinesAttributeModel? attributeModel;
  
  GetAllAllPipelinesSuccessState({this.attributeModel});
}

class GetAllPipelinesFailureState extends GetAllPipelinesState {}

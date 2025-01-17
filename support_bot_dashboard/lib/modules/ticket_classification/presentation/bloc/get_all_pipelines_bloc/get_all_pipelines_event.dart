part of 'get_all_pipelines_bloc.dart';

abstract class GetAllPipelinesEvent {}

class GetAllPiplinesInitialEvent extends GetAllPipelinesEvent {
  final String? selectedPipelineValue;
  GetAllPiplinesInitialEvent({this.selectedPipelineValue});
}

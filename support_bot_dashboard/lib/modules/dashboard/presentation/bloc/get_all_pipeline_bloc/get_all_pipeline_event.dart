part of 'get_all_pipeline_bloc.dart';

abstract class GetAllPipelineEvent {}

class GetAllPiplineInitialEvent extends GetAllPipelineEvent {
  final List<String>? selectedPipelineValue;
  GetAllPiplineInitialEvent({this.selectedPipelineValue});
}
class GetAllValidationUsersInitialEvent extends GetAllPipelineEvent{}
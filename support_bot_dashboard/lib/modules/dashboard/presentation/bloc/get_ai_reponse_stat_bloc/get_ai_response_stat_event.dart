part of 'get_ai_response_stat_bloc.dart';

abstract class GetAiResponseStatEvent {}

class GetAiResponseStatInitialEvent extends GetAiResponseStatEvent {
  final List<String>? selectedPipelineValue;
  final DateTime? startDate;
  final DateTime? endDate;
  GetAiResponseStatInitialEvent({
    this.selectedPipelineValue,
    this.startDate,
    this.endDate,
  });
}

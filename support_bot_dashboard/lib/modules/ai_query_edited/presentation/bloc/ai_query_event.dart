part of 'ai_query_bloc.dart';

abstract class AiQueryEvent {}

class AIQueryInitialEvent extends AiQueryEvent {
  final List<String>? selectedPipelineValue;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? classificationFilterValue;
  final num? page;
  final num? pageSize;
  AIQueryInitialEvent(
      {required this.startDate,
      required this.endDate,
      this.classificationFilterValue,
      this.selectedPipelineValue,
      this.page,
      this.pageSize});
}

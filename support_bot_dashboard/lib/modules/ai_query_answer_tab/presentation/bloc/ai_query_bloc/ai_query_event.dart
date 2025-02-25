part of 'ai_query_bloc.dart';

abstract class AiQueryEvent {}

class AIQueryInitialEvent extends AiQueryEvent {
  final String? selectedPipelineValueList;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? classificationFilterValue;
  final num? page;
  final num? pageSize;
  AIQueryInitialEvent(
      {this.startDate,
      this.endDate,
      this.classificationFilterValue,
      this.selectedPipelineValueList,
      this.page,
      this.pageSize});
}

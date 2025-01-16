part of 'ai_query_bloc.dart';

abstract class AiQueryState {}

class AIQueryInitialState extends AiQueryState {}

class AIQueryLoadingState extends AiQueryState {}

class AIQueryEmptyState extends AiQueryState {}

class AIQuerySuccessState extends AiQueryState {
  final AiQueryAttributeModel? dashboardDataModel;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String>? selectedPipelineValue;
  final String? classificationFilterValue;
  AIQuerySuccessState({
    this.dashboardDataModel,
    this.startDate,
    this.endDate,
    this.selectedPipelineValue,
    this.classificationFilterValue,
  });
}

class AIQueryFailureState extends AiQueryState {}

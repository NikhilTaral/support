part of 'ai_query_bloc.dart';

abstract class AiQueryState {}

class AIQueryInitialState extends AiQueryState {}

class AIQueryLoadingState extends AiQueryState {}

class AIQueryEmptyState extends AiQueryState {}

class AIQuerySucssesState extends AiQueryState {
  final AiQueryAttributeModel? dashboardDataModel;
  AIQuerySucssesState({this.dashboardDataModel});
}

class AIQueryFailureState extends AiQueryState {}

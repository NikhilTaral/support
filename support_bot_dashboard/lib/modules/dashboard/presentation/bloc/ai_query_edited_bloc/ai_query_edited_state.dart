part of 'ai_query_edited_bloc.dart';

abstract class AiQueryEditedState {}

class AIQueryEditedIntialState extends AiQueryEditedState {}

class AIQueryEditedLoadingState extends AiQueryEditedState {}

class AIQueryEditedSucssesState extends AiQueryEditedState {
  final DashboardAiQueryEditedAttributeModel?
      dashboardAiQueryEditedAttributeModel;
  AIQueryEditedSucssesState({this.dashboardAiQueryEditedAttributeModel});
}

class AIQueryEditedFailureState extends AiQueryEditedState {}

class AIQueryEditedEmptyState extends AiQueryEditedState {}

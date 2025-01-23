part of 'ai_query_answer_bloc.dart';

abstract class AiQueryAnswerState {}

class AIQueryAnswerIntialState extends AiQueryAnswerState {}

class AIQueryAnswerLoadingState extends AiQueryAnswerState {}

class AIQueryAnswerEmptyState extends AiQueryAnswerState {}

class AIQueryAnswerSucssesState extends AiQueryAnswerState {
  final DashboardDataModel? dashboardDataModel;
  AIQueryAnswerSucssesState({this.dashboardDataModel});
}

class AIQueryAnswerFailureState extends AiQueryAnswerState {
  final String message;
  
  AIQueryAnswerFailureState(
      {required this.message,
   });
}

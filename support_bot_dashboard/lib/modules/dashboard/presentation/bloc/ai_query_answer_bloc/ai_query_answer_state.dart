part of 'ai_query_answer_bloc.dart';

abstract class AiQueryAnswerState {}

class AIQueryAnswerIntialState extends AiQueryAnswerState {}

class AIQueryAnswerLoadingState extends AiQueryAnswerState {}

class AIQueryAnswerSucssesState extends AiQueryAnswerState {
  final DashboardDataModel? dashboardDataModel;
  AIQueryAnswerSucssesState({this.dashboardDataModel});
}

class AIQueryAnswerFailureState extends AiQueryAnswerState {
  final String message;
  final DateTime selectedDate;
  final DateTime selectedMonth;
  AIQueryAnswerFailureState(
      {required this.message,
      required this.selectedDate,
      required this.selectedMonth});
}

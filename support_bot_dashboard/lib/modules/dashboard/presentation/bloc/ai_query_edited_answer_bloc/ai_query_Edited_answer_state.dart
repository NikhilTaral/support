part of 'ai_query_Edited_answer_bloc.dart';

abstract class AiQueryEditedAnswerState {}

class AIQueryEditedAnswerIntialState extends AiQueryEditedAnswerState {}

class AIQueryEditedAnswerLoadingState extends AiQueryEditedAnswerState {}

class AIQueryEditedAnswerSucssesState extends AiQueryEditedAnswerState {
  final DashboardDataModel? dashboardDataModel;
  AIQueryEditedAnswerSucssesState({this.dashboardDataModel});
}

class AIQueryEditedAnswerFailureState extends AiQueryEditedAnswerState {
  final String message;
  final DateTime selectedDate;
  final DateTime selectedMonth;
  AIQueryEditedAnswerFailureState(
      {required this.message,
      required this.selectedDate,
      required this.selectedMonth});
}

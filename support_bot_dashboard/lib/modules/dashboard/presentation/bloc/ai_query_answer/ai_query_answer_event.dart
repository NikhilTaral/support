part of 'ai_query_answer_bloc.dart';

abstract class AiQueryAnswerEvent{}

class FetchAiQueryAnswerEvent extends AiQueryAnswerEvent{
  final DateTime selectedDate;
  final DateTime selectedMonth;

  FetchAiQueryAnswerEvent({required this.selectedDate, required this.selectedMonth});
}
class SelectedDateEvent extends AiQueryAnswerEvent {
  final DateTime selectedDate;

  SelectedDateEvent({required this.selectedDate});
}

class SelectedMonthEvent extends AiQueryAnswerEvent {
  final DateTime selectedMonth;

  SelectedMonthEvent({required this.selectedMonth});
}

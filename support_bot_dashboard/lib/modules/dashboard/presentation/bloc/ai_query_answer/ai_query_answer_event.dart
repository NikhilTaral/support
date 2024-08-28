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
class UpdateAiAnswerInitialEvent extends AiQueryAnswerEvent {
  final String? ticketId;
  final String? newAnswer;
  final DateTime selectedDate;
  final DateTime selectedMonth;
  UpdateAiAnswerInitialEvent( 
      {required this.ticketId,
      required this.newAnswer,
      required this.selectedDate,
      required this.selectedMonth});
}
class FilterAiAnsweClassificationEvent extends AiQueryAnswerEvent{
  final bool? selectedClassification;
  final DateTime selectDate;
  final DateTime selectMonth;

  FilterAiAnsweClassificationEvent({required this.selectedClassification, required this.selectDate, required this.selectMonth});
}
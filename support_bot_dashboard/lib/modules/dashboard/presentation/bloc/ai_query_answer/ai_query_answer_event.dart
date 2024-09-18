part of 'ai_query_answer_bloc.dart';

abstract class AiQueryAnswerEvent{}

class FetchAiQueryAnswerEvent extends AiQueryAnswerEvent{
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? selectedPipeline;

  FetchAiQueryAnswerEvent({this.selectedDate, this.selectedMonth,this.selectedPipeline});
}
class SelectedDateEvent extends AiQueryAnswerEvent {
  final DateTime selectedDate;
  final String? selectedPipeline;

  SelectedDateEvent({required this.selectedDate,this.selectedPipeline});
}

class SelectedMonthEvent extends AiQueryAnswerEvent {
  final DateTime selectedMonth;
  final String? selectedPipeline;

  SelectedMonthEvent({required this.selectedMonth, this.selectedPipeline});
}
class UpdateAiAnswerInitialEvent extends AiQueryAnswerEvent {
  final String? ticketId;
  final String? newAnswer;
  final String? selectedPipeline;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  UpdateAiAnswerInitialEvent( 
      {required this.ticketId,
      required this.newAnswer,
      this.selectedPipeline,
      required this.selectedDate,
      required this.selectedMonth});
}
class FilterAiAnsweClassificationEvent extends AiQueryAnswerEvent{
  final bool? selectedClassification;
  final String? selectedPipeline;
  final DateTime? selectDate;
  final DateTime? selectMonth;

  FilterAiAnsweClassificationEvent({required this.selectedClassification, required this.selectDate, required this.selectMonth, this.selectedPipeline});
}
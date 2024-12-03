part of 'ai_query_answer_bloc.dart';

abstract class AiQueryAnswerEvent {}

class FetchAiQueryAnswerEvent extends AiQueryAnswerEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? selectedPipeline;
  final bool? isAIAnswer;
  final num? page;
  final num? pageSize;
  final bool? selectedClassification;

  FetchAiQueryAnswerEvent(
      {this.selectedDate,
      this.selectedMonth,
      this.selectedPipeline,
      this.isAIAnswer,
      required this.selectedClassification,
      this.page,
      this.pageSize});
}

class SelectedDateEvent extends AiQueryAnswerEvent {
  final DateTime selectedDate;
  final String? selectedPipeline;
  final num? page;
  final num? pageSize;

  SelectedDateEvent(
      {required this.selectedDate,
      this.selectedPipeline,
      required this.pageSize,
      required this.page});
}

class SelectedMonthEvent extends AiQueryAnswerEvent {
  final DateTime selectedMonth;
  final String? selectedPipeline;
  final num? page;
  final num? pageSize;

  SelectedMonthEvent(
      {required this.selectedMonth,
      this.selectedPipeline,
      required this.page,
      required this.pageSize});
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

class SendEmailAiAnswerInitialEvent extends AiQueryAnswerEvent {
  final String? ticketId;
  final bool? agentAnsvalidation ;
  final String? selectedPipeline;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  SendEmailAiAnswerInitialEvent(
      {required this.ticketId,
      required this.agentAnsvalidation,
      this.selectedPipeline,
      required this.selectedDate,
      required this.selectedMonth});
}

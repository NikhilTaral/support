part of 'ai_query_answer_bloc.dart';

abstract class AiQueryAnswerState {}

class AiQueryAnswerInitial extends AiQueryAnswerState {}

class AiQueryAnswerLoading extends AiQueryAnswerState {}

class AiQueryAnswerSuccess extends AiQueryAnswerState {
  final DashboardAiQueryAttributeModel data;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? selectedPipeline;
  final bool? selectedClassification;
  final String? classification;

  AiQueryAnswerSuccess(
      {required this.data,
      required this.selectedDate,
      required this.selectedMonth,
      required this.selectedClassification,
      required this.classification,
      this.selectedPipeline});
}

class AiQUeryAnswerFailure extends AiQueryAnswerState {
  final String message;
  final String? selectedClassification;

  AiQUeryAnswerFailure({required this.message, this.selectedClassification});
}

class AiQueryAnswerEmpty extends AiQueryAnswerState {}

class UpdateSelectedDateState extends AiQueryAnswerState {
  final DateTime selectedDate;
  final String? selectedPipeline;

  UpdateSelectedDateState({required this.selectedDate, this.selectedPipeline});
}

class UpdateSelectedMonthState extends AiQueryAnswerState {
  final DateTime selectedMonth;
  final String? selectedPipeline;

  UpdateSelectedMonthState(
      {required this.selectedMonth, this.selectedPipeline});
}

final class UpdateAiAnswerLoadingState extends AiQueryAnswerState {}

final class UpdateAiAnswerSuccessState extends AiQueryAnswerState {
  // final DashboardAiQueryAttributeModel data;
  final String? ticketId;
  final String? newAnswer;
  final String? selectedPipeline;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;

  UpdateAiAnswerSuccessState({
    //required this.data,
    this.selectedPipeline,
    required this.selectedDate,
    required this.selectedMonth,
    required this.ticketId,
    required this.newAnswer,
  });
}

final class UpdateAiAnswerFailureState extends AiQueryAnswerState {}

final class UpdateAiAnswerEmptyState extends AiQueryAnswerState {}

final class SendEmailAiAnswerLoadingState extends AiQueryAnswerState {}

final class SendEmailAiAnswerSuccessState extends AiQueryAnswerState {
  // final DashboardAiQueryAttributeModel data;
  final String? ticketId;
  final bool? agentAnsvalidation;
  final String? selectedPipeline;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;

  SendEmailAiAnswerSuccessState({
    //required this.data,
    this.selectedPipeline,
    required this.selectedDate,
    required this.selectedMonth,
    required this.ticketId,
    required this.agentAnsvalidation,
  });
}

final class SendEmailAiAnswerFailureState extends AiQueryAnswerState {}

final class SendEmailAiAnswerEmptyState extends AiQueryAnswerState {}
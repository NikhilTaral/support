part of 'ai_query_answer_bloc.dart';

abstract class AiQueryAnswerState {}

class AiQueryAnswerInitial extends AiQueryAnswerState{}

class AiQueryAnswerLoading extends AiQueryAnswerState{}

class AiQueryAnswerSuccess extends AiQueryAnswerState{
  final DashboardAiQueryAttributeModel data;
   final DateTime selectedDate;
  final DateTime selectedMonth;
  final bool? selectedClassification;
  final String? classification;

  AiQueryAnswerSuccess({required this.data, required this.selectedDate, required this.selectedMonth,required this.selectedClassification, required this.classification});
}

class AiQUeryAnswerFailure extends AiQueryAnswerState{
  final String message;

  AiQUeryAnswerFailure({required this.message});
}

class AiQueryAnswerEmpty extends AiQueryAnswerState{}

class UpdateSelectedDateState extends AiQueryAnswerState {
  final DateTime selectedDate;

  UpdateSelectedDateState({required this.selectedDate});
}

class UpdateSelectedMonthState extends AiQueryAnswerState {
  final DateTime selectedMonth;

  UpdateSelectedMonthState({required this.selectedMonth});
}

final class UpdateAiAnswerLoadingState extends AiQueryAnswerState {}

final class UpdateAiAnswerSuccessState extends AiQueryAnswerState {
 // final DashboardAiQueryAttributeModel data;
  final String? ticketId;
  final String? newAnswer;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;

  UpdateAiAnswerSuccessState(
      {
        //required this.data,
      required this.selectedDate,
      required this.selectedMonth, required this.ticketId, required this.newAnswer,
    });
}

final class UpdateAiAnswerFailureState extends AiQueryAnswerState {}

final class UpdateAiAnswerEmptyState extends AiQueryAnswerState {}

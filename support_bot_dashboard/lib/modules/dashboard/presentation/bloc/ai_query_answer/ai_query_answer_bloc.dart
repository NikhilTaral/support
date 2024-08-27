import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_ai_query_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_ai_query_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_update_ai_query_usecase.dart';

part 'ai_query_answer_event.dart';
part 'ai_query_answer_state.dart';

class AiQueryAnswerBloc extends Bloc<AiQueryAnswerEvent, AiQueryAnswerState> {
  AiQueryAnswerBloc() : super(AiQueryAnswerInitial()) {
    on<FetchAiQueryAnswerEvent>(_onAiQueryAnswerEvent);
    on<SelectedDateEvent>(_onSelectedDateEvent);
    on<SelectedMonthEvent>(_onSelectedMonthEvent);
    on<UpdateAiAnswerInitialEvent>(UpdateAiAnswers);
    on<FilterAiAnsweClassificationEvent>(_onFilterAiAnsweClassificationEvent);
  }

  FutureOr<void> _onAiQueryAnswerEvent(
      FetchAiQueryAnswerEvent event, Emitter<AiQueryAnswerState> emit) async {
    emit(AiQueryAnswerLoading());
    try {
      final repository = serviceLocator<DashboardAiQueryUsecase>();
      final response = await repository.invoke(
          event.selectedDate, event.selectedMonth, "11257490");
      if (response.isLeft) {
        emit(AiQUeryAnswerFailure(message: 'Failed to fetch data'));
      } else {
        final model = DashboardAiQueryResponseModel.fromJson(response.right);
        List<AiQueryAnswerTableItem> items =
            (model.data?.items as List<Items>).map((item) {
          return AiQueryAnswerTableItem(
              id: item.id ?? "",
              createdAt: item.createdAt ?? "",
              ticketDescription: item.ticketDescription,
              aIResponse: item.aIResponse,
              classification: item.classification,
              isAnswerEdited: item.isAnswerEdited,
              answerValidation: item.answerValidation,
              answerValidationReason: item.answerValidationReason);
        }).toList();

        final aiQueryAnswerTableData =
            DashboardAiQueryAttributeModel(items: items);

        emit(AiQueryAnswerSuccess(
            data: aiQueryAnswerTableData,
            selectedDate: event.selectedDate,
            selectedMonth: event.selectedMonth));
      }
    } catch (e) {
      emit(AiQUeryAnswerFailure(message: 'Exception occured $e'));
    }
  }

  FutureOr<void> _onSelectedDateEvent(
      SelectedDateEvent event, Emitter<AiQueryAnswerState> emit) {
    emit(UpdateSelectedDateState(selectedDate: event.selectedDate));
    add(FetchAiQueryAnswerEvent(
        selectedDate: event.selectedDate, selectedMonth: DateTime(2024 - 01)));
  }

  FutureOr<void> _onSelectedMonthEvent(
      SelectedMonthEvent event, Emitter<AiQueryAnswerState> emit) {
    emit(UpdateSelectedMonthState(selectedMonth: event.selectedMonth));
    add(FetchAiQueryAnswerEvent(
        selectedDate: DateTime.now(), selectedMonth: event.selectedMonth));
  }

  FutureOr<void> UpdateAiAnswers(UpdateAiAnswerInitialEvent event,
      Emitter<AiQueryAnswerState> emit) async {
    emit(UpdateAiAnswerLoadingState());
    final repository = serviceLocator<UpdateAiAnswerUsecase>();
    final response = await repository.invoke(event.ticketId, event.newAnswer);
    emit(UpdateAiAnswerSuccessState(
        // data: aiQueryAnswerTableData,
        selectedDate: event.selectedDate,
        selectedMonth: event.selectedMonth,
        ticketId: event.ticketId,
        newAnswer: event.newAnswer));
  }

  FutureOr<void> _onFilterAiAnsweClassificationEvent(
      FilterAiAnsweClassificationEvent event,
      Emitter<AiQueryAnswerState> emit) async {
    emit(AiQueryAnswerLoading());
    try {
      final repository = serviceLocator<DashboardFilterAiQueryUsecase>();
      final response = await repository.invoke(
          event.selectDate, event.selectMonth, event.selectedClassification);
      if (response.isLeft) {
        emit(AiQUeryAnswerFailure(message: "Failed to fetch data"));
      } else {
        final model = DashboardAiQueryResponseModel.fromJson(response.right);
        List<AiQueryAnswerTableItem> items =
            (model.data?.items as List<Items>).map((item) {
          return AiQueryAnswerTableItem(
              id: item.id ?? "",
              createdAt: item.createdAt ?? "",
              ticketDescription: item.ticketDescription,
              aIResponse: item.aIResponse,
              classification: item.classification,
              isAnswerEdited: item.isAnswerEdited,
              answerValidation: item.answerValidation,
              answerValidationReason: item.answerValidationReason);
        }).toList();

        final aiQueryAnswerTableData =
            DashboardAiQueryAttributeModel(items: items);

        emit(AiQueryAnswerSuccess(
            data: aiQueryAnswerTableData,
            selectedDate: event.selectDate,
            selectedMonth: event.selectMonth));
      }
    } catch (e) {
      emit(AiQUeryAnswerFailure(message: 'Exception occured $e'));
    }
  }
}

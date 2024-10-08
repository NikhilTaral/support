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
    on<UpdateAiAnswerInitialEvent>(_onUpdateAiAnswers);
    on<FilterAiAnsweClassificationEvent>(_onFilterAiAnsweClassificationEvent);
  }

  FutureOr<void> _onAiQueryAnswerEvent(
      FetchAiQueryAnswerEvent event, Emitter<AiQueryAnswerState> emit) async {
    emit(AiQueryAnswerLoading());
    try {
      final repository = serviceLocator<DashboardAiQueryUsecase>();
      final response = await repository.invoke(
          event.selectedDate, event.selectedMonth, event.selectedPipeline);
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
              answeredStatus: item.answeredStatus,
              isAnswerEdited: item.isAnswerEdited,
              answerValidation: item.answerValidation,
              answerValidationReason: item.answerValidationReason);
        }).toList();

        final aiQueryAnswerTableData =
            DashboardAiQueryAttributeModel(items: items);

        emit(AiQueryAnswerSuccess(
            data: aiQueryAnswerTableData,
            selectedPipeline: event.selectedPipeline,
            selectedDate: event.selectedDate ?? DateTime.now(),
            selectedMonth: event.selectedMonth ?? DateTime(2024 - 01),
            selectedClassification: null,
            classification: 'Select'));
      }
    } catch (e) {
      emit(AiQUeryAnswerFailure(message: 'Exception occured $e'));
    }
  }

  FutureOr<void> _onSelectedDateEvent(
      SelectedDateEvent event, Emitter<AiQueryAnswerState> emit) {
    emit(UpdateSelectedDateState(selectedDate: event.selectedDate,selectedPipeline: event.selectedPipeline));
    add(FetchAiQueryAnswerEvent(
        selectedDate: event.selectedDate, selectedMonth: null, selectedPipeline: event.selectedPipeline));
  }

  FutureOr<void> _onSelectedMonthEvent(
      SelectedMonthEvent event, Emitter<AiQueryAnswerState> emit) {
    emit(UpdateSelectedMonthState(selectedMonth: event.selectedMonth,selectedPipeline: event.selectedPipeline));
    add(FetchAiQueryAnswerEvent(
        selectedDate: null, selectedMonth: event.selectedMonth, selectedPipeline: event.selectedPipeline));
  }

  FutureOr<void> _onUpdateAiAnswers(UpdateAiAnswerInitialEvent event,
      Emitter<AiQueryAnswerState> emit) async {
    emit(UpdateAiAnswerLoadingState());
    final repository = serviceLocator<UpdateAiAnswerUsecase>();
    final response = await repository.invoke(event.ticketId, event.newAnswer,event.selectedPipeline);
    emit(UpdateAiAnswerSuccessState(
        // data: aiQueryAnswerTableData,
        selectedDate: event.selectedDate,
        selectedMonth: event.selectedMonth,
        selectedPipeline: event.selectedPipeline,
        ticketId: event.ticketId,
        newAnswer: event.newAnswer));
  }

  FutureOr<void> _onFilterAiAnsweClassificationEvent(
      FilterAiAnsweClassificationEvent event,
      Emitter<AiQueryAnswerState> emit) async {
    emit(AiQueryAnswerLoading());
    try {
      final repository = serviceLocator<DashboardFilterAiQueryUsecase>();
      final response = await repository.invoke(event.selectDate,
          event.selectMonth, event.selectedClassification, event.selectedPipeline);
      if (response.isLeft) {
        emit(AiQUeryAnswerFailure(message: "Failed to fetch data",selectedClassification: event.selectedClassification == true
                  ? 'Answered'
                  : event.selectedClassification == false
                      ? 'Not Answered'
                      : 'Select'));
      } else {
        final model = DashboardAiQueryResponseModel.fromJson(response.right);
        List<AiQueryAnswerTableItem> items =
            (model.data?.items as List<Items>).map((item) {
          return AiQueryAnswerTableItem(
              id: item.id ?? "",
              createdAt: item.createdAt ?? "",
              ticketDescription: item.ticketDescription,
              aIResponse: item.aIResponse,
              answeredStatus: item.answeredStatus,
              isAnswerEdited: item.isAnswerEdited,
              answerValidation: item.answerValidation,
              answerValidationReason: item.answerValidationReason);
        }).toList();

        final aiQueryAnswerTableData =
            DashboardAiQueryAttributeModel(items: items);

        emit(
          AiQueryAnswerSuccess(
              data: aiQueryAnswerTableData,
              selectedDate: event.selectDate ?? DateTime.now(),
              selectedMonth: event.selectMonth ?? DateTime(2024 - 01),
              selectedClassification: event.selectedClassification,
              selectedPipeline: event.selectedPipeline,
              classification: event.selectedClassification == true
                  ? 'Answered'
                  : event.selectedClassification == false
                      ? 'Not Answered'
                      : 'Select'),
        );
      }
    } catch (e) {
      emit(AiQUeryAnswerFailure(message: 'Exception occured $e',selectedClassification: event.selectedClassification == true
                  ? 'Answered'
                  : event.selectedClassification == false
                      ? 'Not Answered'
                      : 'Select'));
    }
  }
}

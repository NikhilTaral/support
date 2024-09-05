import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_ai_query_chart_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_chart_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_ai_query_chart_usecase.dart';

part 'ai_query_chart_event.dart';
part 'ai_query_chart_state.dart';

class AiQueryChartBloc extends Bloc<AiQueryChartEvent, AiQueryChartState> {
  AiQueryChartBloc() : super(AiQueryChartInitial()) {
    on<FetchAiQueryChartData>(_onFetchAiQueryChartData);
    on<SelectedChartDateEvent>(_onSelectedChartDateEvent);
    on<SelectedChartMonthEvent>(_onSelectedChartMonthEvent);
  }

  FutureOr<void> _onFetchAiQueryChartData(
      FetchAiQueryChartData event, Emitter<AiQueryChartState> emit) async {
    emit(AiQueryChartLoading());
    try {
      final repository = serviceLocator<DashboardAiQueryChartUsecase>();
      final response = await repository.invoke(
          event.selectedDate, event.selectedMonth, "11257490");
      if (response.isLeft) {
        emit(AiQueryChartFailure(message: 'Failed to fetch chart data'));
      } else {
        final model =
            DashboardAiQueryChartResponseModel.fromJson(response.right);
        if (model.success == true) {
          final dashboardAiQueryChartData = DashboardAiQueryChartAttributeModel(
              aiQueryAnswer: model.data?.aiQueryAnswer,
              aiQueryNotAnswer: model.data?.aiQueryNotAnswer);

          emit(AiQueryChartSuccess(
              pieChartData: dashboardAiQueryChartData,
              selectedDate: event.selectedDate,
              selectedMonth: event.selectedMonth));
        }
      }
    } catch (e) {
      emit(AiQueryChartFailure(message: 'Exception $e'));
    }
  }

  FutureOr<void> _onSelectedChartDateEvent(
      SelectedChartDateEvent event, Emitter<AiQueryChartState> emit) {
    emit(UpdateSelectedChartDateState(selectedDate: event.selectedDate));
    add(FetchAiQueryChartData(
        selectedDate: event.selectedDate, selectedMonth: DateTime(2024 - 01)));
  }

  FutureOr<void> _onSelectedChartMonthEvent(
      SelectedChartMonthEvent event, Emitter<AiQueryChartState> emit) {
    emit(UpdateSelectedChartMonthState(selectedMonth: event.selectedMonth));
    add(FetchAiQueryChartData(
        selectedDate: DateTime.now(), selectedMonth: event.selectedMonth));
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_chart_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_chartdata_usecase.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<UpdateSelectedMonthEvent>(_onUpdateSelectedMonthEvent);
    on<UpdateSelectedDateEvent>(_onUpdateSelectedDateEvent);
    on<FetchDashboardDataEvent>(_onFetchDashboardData);
  }

  Future<void> _onUpdateSelectedDateEvent(
      UpdateSelectedDateEvent event, Emitter<DashboardState> emit) async {
    emit(DateUpdatedState(event.selectedDate));
    add(FetchDashboardDataEvent(event.selectedDate, DateTime(2024, 1), null));
  }

  Future<void> _onUpdateSelectedMonthEvent(
      UpdateSelectedMonthEvent event, Emitter<DashboardState> emit) async {
    emit(MonthUpdatedState(event.selectedMonth));
    print(event.selectedMonth);
    add(FetchDashboardDataEvent(null, event.selectedMonth, null));
  }

  Future<void> _onFetchDashboardData(
      FetchDashboardDataEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardDataLoading());
    final repository = serviceLocator<DashboardChartdataUsecase>();

    // Fetch both count data and pie chart data
    final response =
        await repository.invoke(event.selectedDate, event.selectedMonth,'11257490');

    if (response.isLeft) {
      emit(DashboardDataError(
        message: "Failed to fetch data",
        selectedDate: event.selectedDate ?? DateTime.now(),
        selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
      ));
    } else {
      try {
        final model =
            dashboardChartResponseModelFromJson(jsonEncode(response.right));

        if (model.success == true) {
          final dashboardChartData = DashboardChartAttributeModel(
            genuineQuery: model.data?.genuineQuery ?? 0,
            noActionRequired: model.data?.noActionRequired ?? 0,
            spamMarketing: model.data?.spamMarketing ?? 0,
            acknowledgement: model.data?.acknowledgement ?? 0,
          );

          emit(DashboardDataSuccess(
            pieChartData: dashboardChartData,
            selectedDate: event.selectedDate ?? DateTime.now(),
            selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
          ));
        } else {
          emit(DashboardDataError(
            message: model.message ?? 'Unknown error',
            selectedDate: event.selectedDate ?? DateTime.now(),
            selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
          ));
        }
      } catch (e) {
        emit(DashboardDataError(
          message: 'Failed to parse data',
          selectedDate: event.selectedDate ?? DateTime.now(),
          selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
        ));
      }
    }
  }
}

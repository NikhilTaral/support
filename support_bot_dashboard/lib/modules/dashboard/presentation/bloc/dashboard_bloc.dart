import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_response_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_chart_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_chartdata_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_table_data_usecase.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
     DashboardChartAttributeModel? dashboardchartdata;
  DashboardBloc() : super(DashboardInitial()) {
    on<FetchTableDataEvent>(_onFetchDataEvent);
    on<SelectDropdownEvent>(_onSelectDropdownEvent);
    on<LoadPiechartData>(_onLoadPiechartData);
    on<SelectTimePeriodEvent>(_onSelectTimePeriodEvent);
  }

  FutureOr<void> _onFetchDataEvent(
      FetchTableDataEvent event, Emitter<DashboardState> emit) async {
    final DashboardDatausecase fetchDataUsecase =
        locator<DashboardDatausecase>();
    emit(DashboardDataLoading());
    print('Fetching data...');
    try {
      final data = await fetchDataUsecase.call();
      emit(
        DashboardDataSuccess(
          data: data,
          selectedClassification: 'Spam',
          columnNames:
              data.isNotEmpty ? data.first.toJson().keys.toList() : <String>[],
          selectColumn:
              data.isNotEmpty ? data.first.toJson().keys.toList() : <String>[],
        ),
      );
      print('Data fetched successfully: $data');
    } catch (e) {
      emit(DashboardDataFailure(errorMsg: 'Failed to load data: $e'));
      print('Data fetch failed: $e');
    }
  }

  FutureOr<void> _onSelectDropdownEvent(
      SelectDropdownEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardDataLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(
      DashboardDataSuccess(
        selectedClassification: event.selectedClassification,
        data: event.data,
        columnNames: event.columnNames,
        selectColumn: event.columnNames,
      ),
    );
    print('Dropdown selection updated: ${event.selectedClassification}');
  }

  FutureOr<void> _onLoadPiechartData(
      LoadPiechartData event, Emitter<DashboardState> emit) async {

      emit(PiechartLoading());
      final repository = locator<DashboardChartdataUsecase>();
      final response = await repository.invoke(event.selectedDate);

      response.fold(
        (failure) => emit(PieChartError(message: "Failed to fetch data")),
        (model) {
          if (model.success == true) {
            final dashboardchartdata = DashboardChartAttributeModel(
              genuineQuery: model.data?.genuineQuery ?? 0,
              noActionRequired: model.data?.noActionRequired ?? 0,
              spamMarketing: model.data?.spamMarketing ?? 0,
            );
            emit(PiechartDataSuccess(data: dashboardchartdata));
          } else {
            emit(PieChartError(message: model.message ?? 'Unknown error'));
          }
        },
      );
  }

  FutureOr<void> _onSelectTimePeriodEvent(
      SelectTimePeriodEvent event, Emitter<DashboardState> emit) {
    emit(TimePeriodSelectionState(
      selectedTimePeriod: event.selectedTimePeriod,
    ));
    print('Time period selection updated: ${event.selectedTimePeriod}');
  }
}

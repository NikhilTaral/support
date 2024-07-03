import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_response_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_chartdata_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_data_usecase.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  List<String> temporarySelectedColumns = [];
  DashboardBloc() : super(DashboardInitial()) {
    on<FetchDataEvent>(_onFetchDataEvent);
    on<SelectDropdownEvent>(_onSelectDropdownEvent);
    on<LoadPiechartData>(_onLoadPiechartData);
  }

  FutureOr<void> _onFetchDataEvent(
      FetchDataEvent event, Emitter<DashboardState> emit) async {
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
    try {
      final DashboardChartdatausecase getPieChartData =
          locator<DashboardChartdatausecase>();
      final pieData = await getPieChartData();
      emit(PiechartDataSuccess(data: pieData));
      print('Pie chart data loaded: $pieData');
    } catch (e) {
      emit(PieChartError(message: e.toString()));
      print('Pie chart data load failed: $e');
    }
  }
}

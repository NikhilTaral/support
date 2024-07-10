
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
  DashboardBloc() : super(DashboardInitial()) {
    on<FetchTableDataEvent>(_onFetchDataEvent);
    on<LoadPiechartData>(_onLoadPiechartData);
    on<UpdateSelectedMonthEvent>(_onUpdateSelectedMonthEvent);
    on<UpdateSelectedDateEvent>(_onUpdateSelectedDateEvent);
    on<FetchCountDataEvent>(_onFetchCountDataEvent);
  }

  Future<void> _onFetchDataEvent(
      FetchTableDataEvent event, Emitter<DashboardState> emit) async {
    final DashboardDatausecase fetchDataUsecase =
        locator<DashboardDatausecase>();
    emit(DashboardDataLoading());
    print('Fetching data...');
    try {
      final data = await fetchDataUsecase.call();
      emit(
        DashboardTableDataSuccess(
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

  Future<void> _onUpdateSelectedDateEvent(
      UpdateSelectedDateEvent event, Emitter<DashboardState> emit) async {
    emit(DateUpdatedState(event.selectedDate));
    add(LoadPiechartData(event.selectedDate, DateTime(2024, 1),null)); 
   
  }

  Future<void> _onUpdateSelectedMonthEvent(
      UpdateSelectedMonthEvent event, Emitter<DashboardState> emit) async{
    emit(MonthUpdatedState(event.selectedMonth));
    print(event.selectedMonth);
    add(LoadPiechartData(null, event.selectedMonth,null));
  }

    Future<void> _onLoadPiechartData(
      LoadPiechartData event, Emitter<DashboardState> emit) async {
    emit(PiechartLoading());
    final repository = locator<DashboardChartdataUsecase>();
    final response = await repository.invoke(event.selectedDate, event.selectedMonth);

    response.fold(
      (failure) => emit(PieChartError(message: "Failed to fetch data")),
      (model) {
        if (model.success == true) {
          final dashboardchartdata = DashboardChartAttributeModel(
            genuineQuery: model.data?.genuineQuery ?? 0,
            noActionRequired: model.data?.noActionRequired ?? 0,
            spamMarketing: model.data?.spamMarketing ?? 0,
          );

          emit(DashboardDataSuccess(
            pieChartData: dashboardchartdata,
            countData: event.countData,
            selectedDate: event.selectedDate ?? DateTime.now(),
            selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
          ));
          add(FetchCountDataEvent(selectedDate: event.selectedDate, selectedMonth: event.selectedMonth, pieChartData: dashboardchartdata));
        } else {
          emit(PieChartError(message: model.message ?? 'Unknown error'));
        }
      },
    );
  }

    Future<void> _onFetchCountDataEvent(
        FetchCountDataEvent event, Emitter<DashboardState> emit) async {
      emit(FetchCountDataLoading());
      final repository = locator<DashboardChartdataUsecase>();
      final response = await repository.invoke(event.selectedDate, event.selectedMonth);

      response.fold(
        (failure) => emit(FetchCountDataError(message: "Failed to fetch data")),
        (model) {
          if (model.success == true) {
            final dashboardchartdata = DashboardChartAttributeModel(
              genuineQuery: model.data?.genuineQuery ?? 0,
              noActionRequired: model.data?.noActionRequired ?? 0,
              spamMarketing: model.data?.spamMarketing ?? 0,
            );

            emit(DashboardDataSuccess(
              pieChartData: event.pieChartData,
              countData: dashboardchartdata,
              selectedDate: event.selectedDate ?? DateTime.now(),
              selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
            ));
          } else {
            emit(PieChartError(message: model.message ?? 'Unknown error'));
          }
        },
      );
    }

}

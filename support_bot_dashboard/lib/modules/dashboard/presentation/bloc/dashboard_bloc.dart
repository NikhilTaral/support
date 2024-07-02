import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_response_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_data_usecase.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  List<String> temporarySelectedColumns = [];
  DashboardBloc() : super(DashboardInitial()) {
    on<FetchDataEvent>(_onFetchDataEvent);
    on<SelectDropdownEvent>(_onSelectDropdownEvent);
    on<ApplyColumnsEvent>(_onApplyColumnEvent);
  }

  FutureOr<void> _onFetchDataEvent(
      FetchDataEvent event, Emitter<DashboardState> emit) async {
    final DashboardDatausecase fetchDataUsecase =
        locator<DashboardDatausecase>();
    emit(DashboardDataLoading());
    try {
      final data = await fetchDataUsecase.call();
      emit(
        DashboardDataSuccess(
          selectedColumns: ['id'],
          data: data,
          columnNames:
              data.isNotEmpty ? data.first.toJson().keys.toList() : <String>[],
          temporarySelectedColumns: ['id'],
        ),
      );
    } catch (e) {
      emit(DashboardDataFailure(errorMsg: 'Failed to load data: $e'));
    }
  }

  FutureOr<void> _onSelectDropdownEvent(
      SelectDropdownEvent event, Emitter<DashboardState> emit) async {
    final currentState = state as DashboardDataSuccess;
    emit(DashboardDataSuccess(
      selectedColumns: currentState.selectedColumns,
      temporarySelectedColumns: event.selectedColumns,
      data: currentState.data,
      columnNames: currentState.columnNames,
    ));
  }

  FutureOr<void> _onApplyColumnEvent(
      ApplyColumnsEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardDataLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(
      DashboardDataSuccess(
        columnNames: event.columnNames,
        selectedColumns: event.selectedColumns,
        data: event.data,
        temporarySelectedColumns: event.selectedColumns,
      ),
    );
  }
}

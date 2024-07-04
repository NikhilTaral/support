part of 'dashboard_bloc.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {
  final String selectedTimePeriod = 'Day';
}

class DashboardDataLoading extends DashboardState {}

class DashboardDataEmpty extends DashboardState {}

class DashboardDataSuccess extends DashboardState {
  final List<DashboardResponseDataModel> data;
  final String selectedClassification;
  final List<String> columnNames;
  final List<String> selectColumn;

  DashboardDataSuccess({
    required this.selectColumn,
    required this.columnNames,
    required this.selectedClassification,
    required this.data,
  });
}

class DashboardDataFailure extends DashboardState {
  final String errorMsg;

  DashboardDataFailure({required this.errorMsg});
}

class PiechartLoading extends DashboardState {}

class PiechartDataSuccess extends DashboardState {
  final List<ChartData> data;

  PiechartDataSuccess({required this.data});
}

class PieChartError extends DashboardState {
  final String message;

  PieChartError({required this.message});
}

class TimePeriodSelectionState extends DashboardState {
  final String selectedTimePeriod;

  TimePeriodSelectionState({
    required this.selectedTimePeriod,
  });
}



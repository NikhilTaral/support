part of 'dashboard_bloc.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardDataLoading extends DashboardState {}

class DashboardDataEmpty extends DashboardState {}

class DashboardDataFailure extends DashboardState {
  final String errorMsg;

  DashboardDataFailure({required this.errorMsg});
}

class PiechartLoading extends DashboardState {}

class PiechartDataSuccess extends DashboardState {
  final DashboardChartAttributeModel? data;
  final DateTime selectedDate;
  final DateTime selectedMonth;

  PiechartDataSuccess(
      {required this.data,
      required this.selectedDate,
      required this.selectedMonth});
}

class PieChartError extends DashboardState {
  final String message;

  PieChartError({required this.message});
}

class DateUpdatedState extends DashboardState {
  final DateTime selectedDate;

  DateUpdatedState(this.selectedDate);
}

class MonthUpdatedState extends DashboardState {
  final DateTime month;

  MonthUpdatedState(this.month);
}

class FetchCountDataLoading extends DashboardState {}

class FetchCountDataSuccess extends DashboardState {
  final DashboardChartAttributeModel? data;
  final DateTime? selecedDate;
  final DateTime? selectedMonth;

  FetchCountDataSuccess(
      {required this.data,
       this.selecedDate,
       this.selectedMonth});
}

class FetchCountDataError extends DashboardState {
  final String message;

  FetchCountDataError({required this.message});
}

class DashboardDataSuccess extends DashboardState {
  final DashboardChartAttributeModel? pieChartData;
  final DashboardChartAttributeModel? countData;
  final DateTime selectedDate;
  final DateTime selectedMonth;

  DashboardDataSuccess({
     this.pieChartData,
     this.countData,
    required this.selectedDate,
    required this.selectedMonth,
  });
}

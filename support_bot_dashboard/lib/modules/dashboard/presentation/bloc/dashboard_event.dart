part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class FetchDashboardDataEvent extends DashboardEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final DashboardChartAttributeModel? pieChartData;

  FetchDashboardDataEvent(this.selectedDate, this.selectedMonth, this.pieChartData);
}

class UpdateSelectedDateEvent extends DashboardEvent {
  final DateTime selectedDate;

  UpdateSelectedDateEvent(this.selectedDate);
}

class UpdateSelectedMonthEvent extends DashboardEvent {
  final DateTime selectedMonth;

  UpdateSelectedMonthEvent(this.selectedMonth);
}

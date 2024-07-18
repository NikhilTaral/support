part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class LoadPiechartData extends DashboardEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final DashboardChartAttributeModel? countData;

  LoadPiechartData(this.selectedDate, this.selectedMonth, this.countData);
}

class UpdateSelectedDateEvent extends DashboardEvent {
  final DateTime selectedDate;

  UpdateSelectedDateEvent(this.selectedDate);
}

class UpdateSelectedMonthEvent extends DashboardEvent {
  final DateTime selectedMonth;

  UpdateSelectedMonthEvent(this.selectedMonth);
}

class FetchCountDataEvent extends DashboardEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final DashboardChartAttributeModel? pieChartData;

  FetchCountDataEvent(
      { this.pieChartData,
       this.selectedDate,
      required this.selectedMonth});
}

part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class FetchTableDataEvent extends DashboardEvent {}

class SelectDropdownEvent extends DashboardEvent {
  final List<DashboardResponseDataModel> data;
  final String selectedClassification;
  final List<String> columnNames;

  SelectDropdownEvent(
      {required this.selectedClassification,
      required this.columnNames,
      required this.data});
}

class LoadPiechartData extends DashboardEvent {
  final DateTime selectedDate;

  LoadPiechartData(this.selectedDate);
}

class SelectTimePeriodEvent extends DashboardEvent {
  final String selectedTimePeriod;

  SelectTimePeriodEvent(this.selectedTimePeriod);
}

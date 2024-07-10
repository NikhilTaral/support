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
  final DateTime? selectedDate;
  final DateTime? selectedMonth;

  LoadPiechartData(this.selectedDate, this.selectedMonth);
}


class UpdateSelectedDateEvent extends DashboardEvent {
  final DateTime selectedDate;

  UpdateSelectedDateEvent(this.selectedDate);
}

class UpdateSelectedMonthEvent extends DashboardEvent {
  final DateTime selectedMonth;

  UpdateSelectedMonthEvent(this.selectedMonth);
}

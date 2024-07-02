part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class FetchDataEvent extends DashboardEvent {}

class SelectDropdownEvent extends DashboardEvent {
  final List<DashboardResponseDataModel> data;
  final List<String> selectedColumns;
  final List<String> columnNames;

  SelectDropdownEvent(
      {required this.selectedColumns,
      required this.columnNames,
      required this.data});
}

class ApplyColumnsEvent extends DashboardEvent {
  final List<DashboardResponseDataModel> data;
  final List<String> selectedColumns;
  final List<String> columnNames;

  ApplyColumnsEvent(
      {required this.data,
      required this.selectedColumns,
      required this.columnNames});
}

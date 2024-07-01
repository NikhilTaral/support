part of 'dashboard_bloc.dart';

enum DateType { day, month, week }

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

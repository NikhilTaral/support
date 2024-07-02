part of 'dashboard_bloc.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardDataLoading extends DashboardState {}

class DashboardDataEmpty extends DashboardState {}

class DashboardDataSuccess extends DashboardState {
  final List<DashboardResponseDataModel> data;
  final List<String> selectedColumns;
  final List<String> columnNames;
  final List<String> temporarySelectedColumns;

  DashboardDataSuccess({
    required this.columnNames,
    required this.temporarySelectedColumns,
    required this.selectedColumns,
    required this.data,
  });
}

class DashboardDataFailure extends DashboardState {
  final String errorMsg;

  DashboardDataFailure({required this.errorMsg});
}

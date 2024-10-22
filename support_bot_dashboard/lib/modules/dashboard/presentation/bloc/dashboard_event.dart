part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class FetchDashboardDataEvent extends DashboardEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? selectedPipeline;

  FetchDashboardDataEvent(
      {this.selectedDate, this.selectedMonth, required this.selectedPipeline});
}

class UpdateSelectedDateEvent extends DashboardEvent {
  final DateTime selectedDate;
  final String? selectedPipeline;

  UpdateSelectedDateEvent(this.selectedDate, this.selectedPipeline);
}

class UpdateSelectedMonthEvent extends DashboardEvent {
  final DateTime selectedMonth;
  final String? selectedPipeline;

  UpdateSelectedMonthEvent(this.selectedMonth, this.selectedPipeline);
}

class GetValidationCountEvent extends DashboardEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String selectedPipeline;

  GetValidationCountEvent(
      {required this.selectedDate,
      required this.selectedMonth,
      required this.selectedPipeline});
}

class GetValidationByCountEvent extends DashboardEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String selectedPipeline;

  GetValidationByCountEvent(
      {required this.selectedDate,
      required this.selectedMonth,
      required this.selectedPipeline});
}

class GetUserSettingsEvent extends DashboardEvent {}
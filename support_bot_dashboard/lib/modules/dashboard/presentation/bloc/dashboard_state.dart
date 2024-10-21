part of 'dashboard_bloc.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardDataLoading extends DashboardState {}

class DashboardDataEmpty extends DashboardState {}



class DateUpdatedState extends DashboardState {
  final DateTime selectedDate;
   final String? selectedPipeline;

  DateUpdatedState(this.selectedDate,this.selectedPipeline);
}

class MonthUpdatedState extends DashboardState{
  final DateTime month;
   final String? selectedPipeline;

  MonthUpdatedState(this.month,this.selectedPipeline);
}



class DashboardDataError extends DashboardState{
  final String message;  
  final DateTime selectedDate;
  final DateTime selectedMonth;

  DashboardDataError({required this.message, required this.selectedDate, required this.selectedMonth});
}

class DashboardDataSuccess extends DashboardState {
  final DashboardChartAttributeModel? pieChartData;
    final ValidationCountAttributeModel? getValidationCountAttributeModel;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? selectedPipeline;

  DashboardDataSuccess({
    required this.pieChartData,
    required this.selectedDate,
    required this.selectedMonth,
    required this.selectedPipeline,
    required this.getValidationCountAttributeModel
  });
}

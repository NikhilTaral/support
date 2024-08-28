part of 'ai_query_chart_bloc.dart';

abstract class AiQueryChartState{}

class AiQueryChartInitial extends AiQueryChartState{}

class AiQueryChartLoading extends AiQueryChartState{}

class AiQueryChartSuccess extends AiQueryChartState{
  final DashboardAiQueryChartAttributeModel? pieChartData;
  final DateTime selectedDate;
  final DateTime selectedMonth;

  AiQueryChartSuccess({required this.pieChartData, required this.selectedDate, required this.selectedMonth});
}

class AiQueryChartEmpty extends AiQueryChartState{}

class AiQueryChartFailure extends AiQueryChartState{
  final String message;

  AiQueryChartFailure({required this.message});
}

class UpdateSelectedChartDateState extends AiQueryChartState {
  final DateTime selectedDate;

  UpdateSelectedChartDateState({required this.selectedDate});
}

class UpdateSelectedChartMonthState extends AiQueryChartState {
  final DateTime selectedMonth;

  UpdateSelectedChartMonthState({required this.selectedMonth});
}

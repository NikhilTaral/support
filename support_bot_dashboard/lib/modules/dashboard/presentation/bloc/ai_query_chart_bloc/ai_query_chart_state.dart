part of 'ai_query_chart_bloc.dart';

abstract class AiQueryChartState{}

class AiQueryChartInitial extends AiQueryChartState{}

class AiQueryChartLoading extends AiQueryChartState{}

class AiQueryChartSuccess extends AiQueryChartState{
  final DashboardAiQueryChartAttributeModel? pieChartData;
  final String? selectedPipeline;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;

  AiQueryChartSuccess({required this.pieChartData, required this.selectedDate, required this.selectedMonth,this.selectedPipeline});
}

class AiQueryChartEmpty extends AiQueryChartState{}

class AiQueryChartFailure extends AiQueryChartState{
  final String message;

  AiQueryChartFailure({required this.message});
}

class UpdateSelectedChartDateState extends AiQueryChartState {
  final DateTime? selectedDate;
  final String? selectedPipeline;

  UpdateSelectedChartDateState({required this.selectedDate,this.selectedPipeline});
}

class UpdateSelectedChartMonthState extends AiQueryChartState {
  final DateTime? selectedMonth;
  final String? selectedPipeline;

  UpdateSelectedChartMonthState({required this.selectedMonth,this.selectedPipeline});
}

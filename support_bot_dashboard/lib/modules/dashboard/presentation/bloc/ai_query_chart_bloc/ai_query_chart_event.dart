part of 'ai_query_chart_bloc.dart';

abstract class AiQueryChartEvent{}

class SelectedChartDateEvent extends AiQueryChartEvent {
  final DateTime? selectedDate;
  final String? selectedPipeline;

  SelectedChartDateEvent({required this.selectedDate,this.selectedPipeline});
}

class SelectedChartMonthEvent extends AiQueryChartEvent {
  final DateTime? selectedMonth;
  final String? selectedPipeline;

  SelectedChartMonthEvent({required this.selectedMonth,this.selectedPipeline});
}

class FetchAiQueryChartData extends AiQueryChartEvent{
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? selectedPipeline;

  FetchAiQueryChartData({required this.selectedDate, required this.selectedMonth,this.selectedPipeline});
}
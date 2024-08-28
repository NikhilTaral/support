part of 'ai_query_chart_bloc.dart';

abstract class AiQueryChartEvent{}

class SelectedChartDateEvent extends AiQueryChartEvent {
  final DateTime selectedDate;

  SelectedChartDateEvent({required this.selectedDate});
}

class SelectedChartMonthEvent extends AiQueryChartEvent {
  final DateTime selectedMonth;

  SelectedChartMonthEvent({required this.selectedMonth});
}

class FetchAiQueryChartData extends AiQueryChartEvent{
  final DateTime selectedDate;
  final DateTime selectedMonth;

  FetchAiQueryChartData({required this.selectedDate, required this.selectedMonth});
}
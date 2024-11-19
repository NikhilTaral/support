class DashboardAiQueryChartAttributeModel {
  final AiQueryData? data;

  DashboardAiQueryChartAttributeModel({
    this.data,
  });
}

class AiQueryData {
  final AiQueryDataCounts? counts;
  final AiQueryDataCounts? percentages;

  AiQueryData({
    this.counts,
    this.percentages,
  });
}

class AiQueryDataCounts {
  final double? answeredCount;
  final double? notAnsweredCount;

  AiQueryDataCounts({
    this.answeredCount,
    this.notAnsweredCount,
  });
}

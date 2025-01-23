class DashboardAiQueryChartAttributeModel {
  final AiQueryData? data;

  DashboardAiQueryChartAttributeModel({
    this.data,
  });

  DashboardAiQueryChartAttributeModel copyWith({
    AiQueryData? data,
  }) {
    return DashboardAiQueryChartAttributeModel(
      data: data ?? this.data,
    );
  }
}

class AiQueryData {
  final AiQueryDataCounts? counts;
  final AiQueryDataCounts? percentages;

  AiQueryData({
    this.counts,
    this.percentages,
  });
  AiQueryData copyWith({
    AiQueryDataCounts? counts,
    AiQueryDataCounts? percentages,
  }) {
    return AiQueryData(
      counts: counts ?? this.counts,
      percentages: percentages ?? this.percentages,
    );
  }
}

class AiQueryDataCounts {
  final double? answered;
  final double? notAnswered;

  AiQueryDataCounts({
    this.answered,
    this.notAnswered,
  });
  AiQueryDataCounts copyWith({
    double? answered,
    double? notAnswered,
  }) {
    return AiQueryDataCounts(
      answered: answered ?? this.answered,
      notAnswered: notAnswered ?? this.notAnswered,
    );
  }
}

class DashboardChartAttributeModel {
  final ChartAttributeData? data;

  DashboardChartAttributeModel({
    this.data,
  });

  DashboardChartAttributeModel copyWith({
    ChartAttributeData? data,
  }) {
    return DashboardChartAttributeModel(
      data: data ?? this.data,
    );
  }
}

class ChartAttributeData {
  final ChartAttributeCounts? counts;
  final ChartAttributeCounts? percentages;

  ChartAttributeData({
    this.counts,
    this.percentages,
  });

  ChartAttributeData copyWith({
    ChartAttributeCounts? counts,
    ChartAttributeCounts? percentages,
  }) {
    return ChartAttributeData(
      counts: counts ?? this.counts,
      percentages: percentages ?? this.percentages,
    );
  }
}

class ChartAttributeCounts {
  final double? genuineQuery;
  final double? noActionRequired;
  final double? spamMarketing;
  final double? acknowledgementRequired;
  final double? notClassified;

  ChartAttributeCounts({
    this.genuineQuery,
    this.noActionRequired,
    this.spamMarketing,
    this.acknowledgementRequired,
    this.notClassified,
  });

  ChartAttributeCounts copyWith({
    double? genuineQuery,
    double? noActionRequired,
    double? spamMarketing,
    double? acknowledgementRequired,
    double? notClassified,
  }) {
    return ChartAttributeCounts(
      genuineQuery: genuineQuery ?? this.genuineQuery,
      noActionRequired: noActionRequired ?? this.noActionRequired,
      spamMarketing: spamMarketing ?? this.spamMarketing,
      acknowledgementRequired:
          acknowledgementRequired ?? this.acknowledgementRequired,
      notClassified: notClassified ?? this.notClassified,
    );
  }
}

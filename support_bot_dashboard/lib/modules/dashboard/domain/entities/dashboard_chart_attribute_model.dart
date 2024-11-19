class DashboardChartAttributeModel {
  final ChartAttributeData? data;

  DashboardChartAttributeModel({
    this.data,
  });
}

class ChartAttributeData {
  final ChartAttributeCounts? counts;
  final ChartAttributeCounts? percentages;

  ChartAttributeData({
    this.counts,
    this.percentages,
  });
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
}

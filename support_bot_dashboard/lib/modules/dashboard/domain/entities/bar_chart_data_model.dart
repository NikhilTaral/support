class BarChartDataModel {
  final String label;
  final double totalPercentage;
  final double validatedPercentage;
  final int totalCount;
  final int validatedCount;

  BarChartDataModel({
    required this.label,
    required this.totalPercentage,
    required this.validatedPercentage,
    required this.totalCount,
    required this.validatedCount,
  });
}

class ChartData {
  final String? label;
  final num? value;
  final double? percentage;

  ChartData({required this.label, required this.value, this.percentage});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      label: json.keys.first,
      value: json['value'],
      percentage: json['percentage'],
    );
  }
}

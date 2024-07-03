class ChartData {
  final String label;
  final int value;

  ChartData({required this.label, required this.value});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      label: json.keys.first,
      value: json['value'],
    );
  }
}

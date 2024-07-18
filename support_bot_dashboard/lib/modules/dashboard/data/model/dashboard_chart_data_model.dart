class ChartData {
  final String? label;
  final num? value;

  ChartData({this.label, this.value});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      label: json.keys.first,
      value: json['value'],
    );
  }
}

class DataModule {
  final List<String>? id;
  final String? classification;
  final DateTime? startData;
  final DateTime? endDate;

  DataModule({
    this.id,
    this.classification,
    this.startData,
    this.endDate,
  });
  DataModule copyWith({
    List<String>? id,
    String? classification,
    DateTime? startData,
    DateTime? endDate,
  }) {
    return DataModule(
      id: id ?? this.id,
      classification: classification ?? this.classification,
      startData: startData ?? this.startData,
      endDate: endDate ?? this.endDate,
    );
  }
}

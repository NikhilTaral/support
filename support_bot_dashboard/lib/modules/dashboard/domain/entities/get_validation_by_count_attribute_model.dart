class GetValidationByCountAttributeModel {
  final ValidationByCountData? data;

  GetValidationByCountAttributeModel({
    this.data,
  });
  GetValidationByCountAttributeModel copyWith({
    ValidationByCountData? data,
  }) {
    return GetValidationByCountAttributeModel(
      data: data ?? this.data,
    );
  }
}

class ValidationByCountData {
  final Map<String, double>? counts;
  final Map<String, double>? percentages;

  ValidationByCountData({
    this.counts,
    this.percentages,
  });
  ValidationByCountData copyWith({
    Map<String, double>? counts,
    Map<String, double>? percentages,
  }) {
    return ValidationByCountData(
      counts: counts ?? this.counts,
      percentages: percentages ?? this.percentages,
    );
  }
}

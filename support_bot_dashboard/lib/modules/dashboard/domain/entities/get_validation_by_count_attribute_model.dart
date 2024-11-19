class GetValidationByCountAttributeModel {
  final ValidationByCountData? data;

  GetValidationByCountAttributeModel({
    this.data,
  });
}

class ValidationByCountData {
  final Map<String, double>? counts;
  final Map<String, double>? percentages;

  ValidationByCountData({
    this.counts,
    this.percentages,
  });
}

class GetValidationCountAttributeModel {
  final ValidationCountData? data;

  GetValidationCountAttributeModel({
    this.data,
  });
}

class ValidationCountData {
  final ValidationCounts? counts;
  final ValidationCounts? percentages;

  ValidationCountData({
    this.counts,
    this.percentages,
  });
}

class ValidationCounts {
  final double? correct;
  final double? incorrect;
  final double? notValidated;

  ValidationCounts({
    this.correct,
    this.incorrect,
    this.notValidated,
  });
}

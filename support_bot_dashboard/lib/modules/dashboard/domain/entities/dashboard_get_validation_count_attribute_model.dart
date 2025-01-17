class GetValidationCountAttributeModel {
  final ValidationCountData? data;

  GetValidationCountAttributeModel({
    this.data,
  });

  GetValidationCountAttributeModel copyWith({
    ValidationCountData? data,
  }) {
    return GetValidationCountAttributeModel(
      data: data ?? this.data,
    );
  }
}

class ValidationCountData {
  final ValidationCounts? counts;
  final ValidationCounts? percentages;

  ValidationCountData({
    this.counts,
    this.percentages,
  });

  ValidationCountData copyWith({
    ValidationCounts? counts,
    ValidationCounts? percentages,
  }) {
    return ValidationCountData(
      counts: counts ?? this.counts,
      percentages: percentages ?? this.percentages,
    );
  }
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

  ValidationCounts copyWith({
    double? correct,
    double? incorrect,
    double? notValidated,
  }) {
    return ValidationCounts(
      correct: correct ?? this.correct,
      incorrect: incorrect ?? this.incorrect,
      notValidated: notValidated ?? this.notValidated,
    );
  }
}

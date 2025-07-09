class GetAiResponseStatAttributeModel {
  final CountsAttribute? counts;
  final CountsAttribute? percentages;

  GetAiResponseStatAttributeModel({
    this.counts,
    this.percentages,
  });
}

class CountsAttribute {
  final double? totalTickets;
  final double? totalResponses;
  final double? validatedResponses;
  final double? correctResponses;
  final double? incorrectResponses;
  final double? needsImprovement;

  CountsAttribute({
    this.totalTickets,
    this.totalResponses,
    this.validatedResponses,
    this.correctResponses,
    this.incorrectResponses,
    this.needsImprovement,
  });
}

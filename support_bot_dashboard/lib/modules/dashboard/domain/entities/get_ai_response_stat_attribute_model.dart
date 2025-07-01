class GetAiResponseStatAttributeModel {
  final Counts? counts;
  final Counts? percentages;

  GetAiResponseStatAttributeModel({
    this.counts,
    this.percentages,
  });
}

class Counts {
  final int? totalTickets;
  final int? totalResponses;
  final double? validatedResponses;
  final double? correctResponses;
  final double? incorrectResponses;
  final double? needsImprovement;

  Counts({
    this.totalTickets,
    this.totalResponses,
    this.validatedResponses,
    this.correctResponses,
    this.incorrectResponses,
    this.needsImprovement,
  });
}

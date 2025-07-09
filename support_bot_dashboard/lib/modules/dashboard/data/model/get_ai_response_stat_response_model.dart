import 'dart:convert';

GetAiResponseStatResonseModel getAiResponseStatFromJson(String str) => GetAiResponseStatResonseModel.fromJson(json.decode(str));

class GetAiResponseStatResonseModel {
  final GetAiResponseCounts? counts;
  final GetAiResponseCounts? percentages;

  GetAiResponseStatResonseModel({
    this.counts,
    this.percentages,
  });

  factory GetAiResponseStatResonseModel.fromJson(Map<String, dynamic> json) => GetAiResponseStatResonseModel(
        counts: json["data"]?["counts"] == null ? null : GetAiResponseCounts.fromJson(json["data"]["counts"]),
        percentages: json["data"]?["percentages"] == null ? null : GetAiResponseCounts.fromJson(json["data"]["percentages"]),
      );
}

class GetAiResponseCounts {
  final num? totalTickets;
  final num? totalResponses;
  final num? validatedResponses;
  final num? correctResponses;
  final num? incorrectResponses;
  final num? needsImprovement;

  GetAiResponseCounts({
    this.totalTickets,
    this.totalResponses,
    this.validatedResponses,
    this.correctResponses,
    this.incorrectResponses,
    this.needsImprovement,
  });

  factory GetAiResponseCounts.fromJson(Map<String, dynamic> json) => GetAiResponseCounts(
        totalTickets: json["totalTickets"],
        totalResponses: json["totalResponses"],
        validatedResponses: json["validatedResponses"]?.toDouble(),
        correctResponses: json["correctResponses"]?.toDouble(),
        incorrectResponses: json["incorrectResponses"]?.toDouble(),
        needsImprovement: json["needsImprovement"]?.toDouble(),
      );
}

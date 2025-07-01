import 'dart:convert';

GetAiResponseStat getAiResponseStatFromJson(String str) => GetAiResponseStat.fromJson(json.decode(str));

class GetAiResponseStat {
  final GetAiResponseCounts? counts;
  final GetAiResponseCounts? percentages;

  GetAiResponseStat({
    this.counts,
    this.percentages,
  });

  factory GetAiResponseStat.fromJson(Map<String, dynamic> json) => GetAiResponseStat(
        counts: json["data"]?["counts"] == null ? null : GetAiResponseCounts.fromJson(json["data"]["counts"]),
        percentages: json["data"]?["percentages"] == null ? null : GetAiResponseCounts.fromJson(json["data"]["percentages"]),
      );
}

class GetAiResponseCounts {
  final num? totalTickets;
  final num? totalResponses;
  final double? validatedResponses;
  final double? correctResponses;
  final double? incorrectResponses;
  final double? needsImprovement;

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

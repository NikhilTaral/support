import 'dart:convert';

class PipelineTileRequestModel {
  final String? startDate;
  final String? endDate;

  PipelineTileRequestModel({
    this.startDate,
    this.endDate,
  });

  PipelineTileRequestModel copyWith({
    String? startDate,
    String? endDate,
  }) =>
      PipelineTileRequestModel(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );

  factory PipelineTileRequestModel.fromRawJson(String str) =>
      PipelineTileRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PipelineTileRequestModel.fromJson(Map<String, dynamic> json) =>
      PipelineTileRequestModel(
        startDate: json["startDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
      };
}

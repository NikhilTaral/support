import 'dart:convert';

PipelineTileResponseModel pipelineTileResponseModelFromJson(String str) =>
    PipelineTileResponseModel.fromJson(json.decode(str));

String pipelineTileResponseModelToJson(PipelineTileResponseModel data) =>
    json.encode(data.toJson());

class PipelineTileResponseModel {
  final Data? data;
  final bool? success;
  final num? failCode;
  final String? message;

  PipelineTileResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  PipelineTileResponseModel copyWith({
    Data? data,
    bool? success,
    num? failCode,
    String? message,
  }) =>
      PipelineTileResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
      );

  factory PipelineTileResponseModel.fromJson(Map<String, dynamic> json) =>
      PipelineTileResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
        failCode: json["failCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "success": success,
        "failCode": failCode,
        "message": message,
      };
}

class Data {
  final num? totalRecords;
  final List<Item>? items;

  Data({
    this.totalRecords,
    this.items,
  });

  Data copyWith({
    num? totalRecords,
    List<Item>? items,
  }) =>
      Data(
        totalRecords: totalRecords ?? this.totalRecords,
        items: items ?? this.items,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalRecords: json["totalRecords"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalRecords": totalRecords,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  final String? pipelineId;
  final String? pipelineName;
  final num? totalTickets;
  final num? correctTickets;
  final num? incorrectTickets;
  final num? validatedTickets;

  Item({
    this.pipelineId,
    this.pipelineName,
    this.totalTickets,
    this.correctTickets,
    this.incorrectTickets,
    this.validatedTickets,
  });

  Item copyWith({
    String? pipelineId,
    String? pipelineName,
    num? totalTickets,
    num? correctTickets,
    num? incorrectTickets,
    num? validatedTickets,
  }) =>
      Item(
        pipelineId: pipelineId ?? this.pipelineId,
        pipelineName: pipelineName ?? this.pipelineName,
        totalTickets: totalTickets ?? this.totalTickets,
        correctTickets: correctTickets ?? this.correctTickets,
        incorrectTickets: incorrectTickets ?? this.incorrectTickets,
        validatedTickets: validatedTickets ?? this.validatedTickets,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        pipelineId: json["PipelineId"],
        pipelineName: json["PipelineName"],
        totalTickets: json["TotalTickets"],
        correctTickets: json["correctTickets"],
        incorrectTickets: json["incorrectTickets"],
        validatedTickets: json["ValidatedTickets"],
      );

  Map<String, dynamic> toJson() => {
        "PipelineId": pipelineId,
        "PipelineName": pipelineName,
        "TotalTickets": totalTickets,
        "correctTickets": correctTickets,
        "incorrectTickets": incorrectTickets,
        "ValidatedTickets": validatedTickets,
      };
}

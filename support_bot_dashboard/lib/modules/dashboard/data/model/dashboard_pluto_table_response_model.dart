
import 'dart:convert';

DashboardPlutotableResponseModel dashboardPlutotableResponseModelFromJson(String str) => DashboardPlutotableResponseModel.fromJson(json.decode(str));

String dashboardPlutotableResponseModelToJson(DashboardPlutotableResponseModel data) => json.encode(data.toJson());

class DashboardPlutotableResponseModel {
    final Data data;
    final bool success;
    final num failCode;
    final Params params;
    final String message;

    DashboardPlutotableResponseModel({
        required this.data,
        required this.success,
        required this.failCode,
        required this.params,
        required this.message,
    });

    factory DashboardPlutotableResponseModel.fromJson(Map<String, dynamic> json) => DashboardPlutotableResponseModel(
        data: Data.fromJson(json["data"]),
        success: json["success"],
        failCode: json["failCode"],
        params: Params.fromJson(json["params"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "success": success,
        "failCode": failCode,
        "params": params.toJson(),
        "message": message,
    };
}

class Data {
    final int totalRecords;
    final List<Item> items;
    final String lastEvaluatedKey;

    Data({
        required this.totalRecords,
        required this.items,
        required this.lastEvaluatedKey,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalRecords: json["totalRecords"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        lastEvaluatedKey: json["lastEvaluatedKey"],
    );

    Map<String, dynamic> toJson() => {
        "totalRecords": totalRecords,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "lastEvaluatedKey": lastEvaluatedKey,
    };
}

class Item {
  final CreatedAt classification;
  final CreatedAt hsPipelineStage;
  final CreatedAt id;
  final CreatedAt reasoning;
  final CreatedAt createdAt;

  Item({
    required this.classification,
    required this.hsPipelineStage,
    required this.id,
    required this.reasoning,
    required this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      classification: json.containsKey("classification") ? CreatedAt.fromJson(json["classification"]) : CreatedAt(s: ''),
      hsPipelineStage: json.containsKey("HS_Pipeline_Stage") ? CreatedAt.fromJson(json["HS_Pipeline_Stage"]) : CreatedAt(s: ''),
      id: json.containsKey("id") ? CreatedAt.fromJson(json["id"]) : CreatedAt(s: ''),
      reasoning: json.containsKey("reasoning") ? CreatedAt.fromJson(json["reasoning"]) : CreatedAt(s: ''),
      createdAt: json.containsKey("CreatedAt") ? CreatedAt.fromJson(json["CreatedAt"]) : CreatedAt(s: ''),
    );
  }

  Map<String, dynamic> toJson() => {
    "classification": classification.toJson(),
    "hSPipelineStage": hsPipelineStage.toJson(),
    "id": id.toJson(),
    "reasoning": reasoning.toJson(),
    "CreatedAt": createdAt.toJson(),
  };
}


class CreatedAt {
    final String s;

    CreatedAt({
        required this.s,
    });

    factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
        s: json["S"],
    );

    Map<String, dynamic> toJson() => {
        "S": s,
    };
}

class Params {
    Params();

    factory Params.fromJson(Map<String, dynamic> json) => Params(
    );

    Map<String, dynamic> toJson() => {
    };
}

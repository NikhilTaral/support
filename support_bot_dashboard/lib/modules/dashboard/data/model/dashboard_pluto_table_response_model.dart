// class DashboardPlutotableResponseModel {
//   final Data? data;
//   final bool? success;
//   final int? failCode;
//   final String? message;

//   DashboardPlutotableResponseModel({
//     this.data,
//     this.success,
//     this.failCode,
//     this.message,
//   });

//   DashboardPlutotableResponseModel.fromJson(Map<String, dynamic> json)
//     : data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null,
//       success = json['success'] as bool?,
//       failCode = json['failCode'] as int?,
//       message = json['message'] as String?;

//   Map<String, dynamic> toJson() => {
//     'data' : data?.toJson(),
//     'success' : success,
//     'failCode' : failCode,
//     'message' : message
//   };
// }

// class Data {
//   final int? totalRecords;
//   final List<Items>? items;
//   final String? lastEvaluatedKey;

//   Data({
//     this.totalRecords,
//     this.items,
//     this.lastEvaluatedKey,
//   });

//   Data.fromJson(Map<String, dynamic> json)
//     : totalRecords = json['totalRecords'] as int?,
//       items = (json['items'] as List?)?.map((dynamic e) => Items.fromJson(e as Map<String,dynamic>)).toList(),
//       lastEvaluatedKey = json['lastEvaluatedKey'] as String?;

//   Map<String, dynamic> toJson() => {
//     'totalRecords' : totalRecords,
//     'items' : items?.map((e) => e.toJson()).toList(),
//     'lastEvaluatedKey' : lastEvaluatedKey
//   };
// }

// class Items {
//   final Classification? classification;
//   final HSPipelineStage? hSPipelineStage;
//   final Id? id;
//   final Reasoning? reasoning;
//   final CreatedAt? createdAt;

//   Items({
//     this.classification,
//     this.hSPipelineStage,
//     this.id,
//     this.reasoning,
//     this.createdAt,
//   });

//   Items.fromJson(Map<String, dynamic> json)
//     : classification = (json['classification'] as Map<String,dynamic>?) != null ? Classification.fromJson(json['classification'] as Map<String,dynamic>) : null,
//       hSPipelineStage = (json['HS_Pipeline_Stage'] as Map<String,dynamic>?) != null ? HSPipelineStage.fromJson(json['HS_Pipeline_Stage'] as Map<String,dynamic>) : null,
//       id = (json['id'] as Map<String,dynamic>?) != null ? Id.fromJson(json['id'] as Map<String,dynamic>) : null,
//       reasoning = (json['reasoning'] as Map<String,dynamic>?) != null ? Reasoning.fromJson(json['reasoning'] as Map<String,dynamic>) : null,
//       createdAt = (json['CreatedAt'] as Map<String,dynamic>?) != null ? CreatedAt.fromJson(json['CreatedAt'] as Map<String,dynamic>) : null;

//   Map<String, dynamic> toJson() => {
//     'classification' : classification?.toJson(),
//     'HS_Pipeline_Stage' : hSPipelineStage?.toJson(),
//     'id' : id?.toJson(),
//     'reasoning' : reasoning?.toJson(),
//     'CreatedAt' : createdAt?.toJson()
//   };
// }

// class Classification {
//   final String? s;

//   Classification({
//     this.s,
//   });

//   Classification.fromJson(Map<String, dynamic> json)
//     : s = json['S'] as String?;

//   Map<String, dynamic> toJson() => {
//     'S' : s
//   };
// }

// class HSPipelineStage {
//   final String? s;

//   HSPipelineStage({
//     this.s,
//   });

//   HSPipelineStage.fromJson(Map<String, dynamic> json)
//     : s = json['S'] as String?;

//   Map<String, dynamic> toJson() => {
//     'S' : s
//   };
// }

// class Id {
//   final String? s;

//   Id({
//     this.s,
//   });

//   Id.fromJson(Map<String, dynamic> json)
//     : s = json['S'] as String?;

//   Map<String, dynamic> toJson() => {
//     'S' : s
//   };
// }

// class Reasoning {
//   final String? s;

//   Reasoning({
//     this.s,
//   });

//   Reasoning.fromJson(Map<String, dynamic> json)
//     : s = json['S'] as String?;

//   Map<String, dynamic> toJson() => {
//     'S' : s
//   };
// }

// class CreatedAt {
//   final String? s;

//   CreatedAt({
//     this.s,
//   });

//   CreatedAt.fromJson(Map<String, dynamic> json)
//     : s = json['S'] as String?;

//   Map<String, dynamic> toJson() => {
//     'S' : s
//   };
// }


// To parse this JSON data, do
//
//     final dashboardPlutotableResponseModel = dashboardPlutotableResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardPlutotableResponseModel dashboardPlutotableResponseModelFromJson(String str) => DashboardPlutotableResponseModel.fromJson(json.decode(str));

String dashboardPlutotableResponseModelToJson(DashboardPlutotableResponseModel data) => json.encode(data.toJson());

class DashboardPlutotableResponseModel {
    final Data data;
    final bool success;
    final int failCode;
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

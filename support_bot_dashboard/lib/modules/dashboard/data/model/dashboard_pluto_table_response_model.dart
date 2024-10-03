import 'dart:convert';

DashboardPlutotableResponseModel dashboardPlutotableResponseModelFromJson(
        String str) =>
    DashboardPlutotableResponseModel.fromJson(json.decode(str));

String dashboardPlutotableResponseModelToJson(
        DashboardPlutotableResponseModel data) =>
    json.encode(data.toJson());

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

  factory DashboardPlutotableResponseModel.fromJson(Map<String, dynamic> json) {
  return DashboardPlutotableResponseModel(
    data: json["data"] is List 
        ? Data(totalRecords: 0, items: [], lastEvaluatedKey: LastEvaluatedKey(),pageSize: 10,currentPage: 1) 
        : Data.fromJson(json["data"]),
    success: json["success"],
    failCode: json["failCode"],
    params: Params.fromJson(json["params"]),
    message: json["message"],
  );
}


  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "success": success,
        "failCode": failCode,
        "params": params.toJson(),
        "message": message,
      };
}

class Data {
  final num totalRecords;
  final List<Item> items;
  final num? pageSize;
  final num? currentPage;
  final LastEvaluatedKey? lastEvaluatedKey;

  Data({
    required this.totalRecords,
    required this.items,
    required this.pageSize,
    required this.currentPage,
    required this.lastEvaluatedKey,
  });

   factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalRecords: json["totalRecords"] ?? 0,
        items: json["items"] != null 
            ? List<Item>.from(json["items"].map((x) => Item.fromJson(x))) 
            : [],
          pageSize: json["pageSize"],
        currentPage: json["currentPage"],
        lastEvaluatedKey: json["lastEvaluatedKey"] == null ? null : LastEvaluatedKey.fromJson(json["lastEvaluatedKey"]),
      );

  Map<String, dynamic> toJson() => {
        "totalRecords": totalRecords,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "pageSize": pageSize,
        "currentPage": currentPage,
        "lastEvaluatedKey": lastEvaluatedKey,
      };
}

class Item {
  final CreatedAt classification;
  final CreatedAt hsPipelineStage;
  final CreatedAt id;
  final CreatedAt reasoning;
  final CreatedAt createdAt;
  final CreatedAt ticketDescription;
  final CreatedAt classificationValidation;
  final CreatedAt classificationValidationReason;
  final IsUpdatedToHubspot? isUpdatedToHubspot;

  Item({
    required this.classification,
    required this.hsPipelineStage,
    required this.id,
    required this.reasoning,
    required this.createdAt,
    required this.ticketDescription,
    required this.classificationValidation,
    required this.classificationValidationReason,
    required this.isUpdatedToHubspot,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      classification: json.containsKey("classification")
          ? CreatedAt.fromJson(json["classification"])
          : CreatedAt(s: ''),
      hsPipelineStage: json.containsKey("HS_Pipeline_Stage")
          ? CreatedAt.fromJson(json["HS_Pipeline_Stage"])
          : CreatedAt(s: ''),
      id: json.containsKey("id")
          ? CreatedAt.fromJson(json["id"])
          : CreatedAt(s: ''),
      reasoning: json.containsKey("reasoning")
          ? CreatedAt.fromJson(json["reasoning"])
          : CreatedAt(s: ''),
      createdAt: json.containsKey("CreatedAt")
          ? CreatedAt.fromJson(json["CreatedAt"])
          : CreatedAt(s: ''),
      ticketDescription: json.containsKey("Ticket_Description")
          ? CreatedAt.fromJson(json["Ticket_Description"])
          : CreatedAt(s: ''),
      classificationValidation: json.containsKey("classificationValidation")
          ? CreatedAt.fromJson(json["classificationValidation"])
          : CreatedAt(s: ''),
      classificationValidationReason:
          json.containsKey("classificationValidationReason")
              ? CreatedAt.fromJson(json["classificationValidationReason"])
              : CreatedAt(s: ''),
      isUpdatedToHubspot: json["isUpdatedToHubspot"] == null
          ? null
          : IsUpdatedToHubspot.fromJson(json["isUpdatedToHubspot"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "classification": classification.toJson(),
        "hSPipelineStage": hsPipelineStage.toJson(),
        "id": id.toJson(),
        "reasoning": reasoning.toJson(),
        "CreatedAt": createdAt.toJson(),
        "ticketDescription": createdAt.toJson(),
        "classificationValidation": createdAt.toJson(),
        "classificationValidationReason": createdAt.toJson(),
        "isUpdatedToHubspot": isUpdatedToHubspot?.toJson(),
      };
}

class LastEvaluatedKey {
    final CreatedAt? id;
    final CreatedAt? dType;
    final CreatedAt? createdAt;

    LastEvaluatedKey({
        this.id,
        this.dType,
        this.createdAt,
    });

    factory LastEvaluatedKey.fromJson(Map<String, dynamic> json) => LastEvaluatedKey(
        id: json["id"] == null ? null : CreatedAt.fromJson(json["id"]),
        dType: json["dType"] == null ? null : CreatedAt.fromJson(json["dType"]),
        createdAt: json["CreatedAt"] == null ? null : CreatedAt.fromJson(json["CreatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id?.toJson(),
        "dType": dType?.toJson(),
        "CreatedAt": createdAt?.toJson(),
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

class IsUpdatedToHubspot {
  final bool isUpdatedToHubspotBool;

  IsUpdatedToHubspot({
    required this.isUpdatedToHubspotBool,
  });

  factory IsUpdatedToHubspot.fromJson(Map<String, dynamic> json) =>
      IsUpdatedToHubspot(
        isUpdatedToHubspotBool: json["BOOL"],
      );

  Map<String, dynamic> toJson() => {
        "BOOL": isUpdatedToHubspotBool,
      };
}

class Params {
  Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}

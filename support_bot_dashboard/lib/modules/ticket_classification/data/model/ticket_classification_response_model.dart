import 'dart:convert';

TicketClassificationResponseModel ticketClassificationResponseModelFromJson(
        String str) =>
    TicketClassificationResponseModel.fromJson(json.decode(str));

String ticketClassificationResponseModelToJson(
        TicketClassificationResponseModel data) =>
    json.encode(data.toJson());

class TicketClassificationResponseModel {
  final Data? data;
  final bool? success;
  final int? failCode;
  final Params? params;
  final String? message;

  TicketClassificationResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  TicketClassificationResponseModel copyWith({
    Data? data,
    bool? success,
    int? failCode,
    Params? params,
    String? message,
  }) =>
      TicketClassificationResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        params: params ?? this.params,
        message: message ?? this.message,
      );

  factory TicketClassificationResponseModel.fromJson(
          Map<String, dynamic> json) =>
      TicketClassificationResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
        failCode: json["failCode"],
        params: json["params"] == null ? null : Params.fromJson(json["params"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "success": success,
        "failCode": failCode,
        "params": params?.toJson(),
        "message": message,
      };
}

class Data {
  num? totalRecords;
  List<Item>? items;
  num? pageSize;
  LastEvaluatedKey? lastEvaluatedKey;
  num? currentPage;

  Data({
    this.totalRecords,
    this.items,
    this.pageSize,
    this.lastEvaluatedKey,
    this.currentPage,
  });

  Data copyWith({
    num? totalRecords,
    List<Item>? items,
    num? pageSize,
    LastEvaluatedKey? lastEvaluatedKey,
    num? currentPage,
  }) =>
      Data(
        totalRecords: totalRecords ?? this.totalRecords,
        items: items ?? this.items,
        pageSize: pageSize ?? this.pageSize,
        lastEvaluatedKey: lastEvaluatedKey ?? this.lastEvaluatedKey,
        currentPage: currentPage ?? this.currentPage,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalRecords: json["totalRecords"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        pageSize: json["pageSize"],
        lastEvaluatedKey: json["lastEvaluatedKey"] == null
            ? null
            : LastEvaluatedKey.fromJson(json["lastEvaluatedKey"]),
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalRecords": totalRecords,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "pageSize": pageSize,
        "lastEvaluatedKey": lastEvaluatedKey?.toJson(),
        "currentPage": currentPage,
      };
}

class Item {
  String? id;
  DateTime? createdAt;
  String? classification;
  bool? isUpdatedToHubspot;
  String? reasoning;
  String? ticketDescription;
  String? classificationValidation;
  String? classificationValidationReason;
  String? classificationValidatedBy;
  String? bopsState;

  Item({
    this.id,
    this.createdAt,
    this.classification,
    this.isUpdatedToHubspot,
    this.reasoning,
    this.ticketDescription,
    this.classificationValidation,
    this.classificationValidationReason,
    this.classificationValidatedBy,
    this.bopsState,
  });

  Item copyWith({
    String? id,
    DateTime? createdAt,
    String? classification,
    bool? isUpdatedToHubspot,
    String? reasoning,
    String? ticketDescription,
    String? classificationValidation,
    String? classificationValidationReason,
    String? classificationValidatedBy,
    String? bopsState,
  }) =>
      Item(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        classification: classification ?? this.classification,
        isUpdatedToHubspot: isUpdatedToHubspot ?? this.isUpdatedToHubspot,
        reasoning: reasoning ?? this.reasoning,
        ticketDescription: ticketDescription ?? this.ticketDescription,
        classificationValidation:
            classificationValidation ?? this.classificationValidation,
        classificationValidationReason: classificationValidationReason ??
            this.classificationValidationReason,
        classificationValidatedBy:
            classificationValidatedBy ?? this.classificationValidatedBy,
        bopsState: bopsState ?? this.bopsState,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        createdAt: json["CreatedAt"] == null
            ? null
            : DateTime.parse(json["CreatedAt"]),
        classification: json["classification"],
        isUpdatedToHubspot: json["isUpdatedToHubspot"],
        reasoning: json["reasoning"],
        ticketDescription: json["Ticket_Description"],
        classificationValidation: json["classificationValidation"],
        classificationValidationReason: json["classificationValidationReason"],
        classificationValidatedBy: json["classificationValidatedBy"],
        bopsState: json["BOPS_State"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "CreatedAt": createdAt?.toIso8601String(),
        "classification": classification,
        "isUpdatedToHubspot": isUpdatedToHubspot,
        "reasoning": reasoning,
        "Ticket_Description": ticketDescription,
        "classificationValidation": classificationValidation,
        "classificationValidationReason": classificationValidationReason,
        "classificationValidatedBy": classificationValidatedBy,
        "BOPS_State": bopsState,
      };
}

class LastEvaluatedKey {
  CreatedAt? hsPipeline;
  CreatedAt? dType;
  CreatedAt? id;
  CreatedAt? createdAt;

  LastEvaluatedKey({
    this.hsPipeline,
    this.dType,
    this.id,
    this.createdAt,
  });

  LastEvaluatedKey copyWith({
    CreatedAt? hsPipeline,
    CreatedAt? dType,
    CreatedAt? id,
    CreatedAt? createdAt,
  }) =>
      LastEvaluatedKey(
        hsPipeline: hsPipeline ?? this.hsPipeline,
        dType: dType ?? this.dType,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
      );

  factory LastEvaluatedKey.fromJson(Map<String, dynamic> json) =>
      LastEvaluatedKey(
        hsPipeline: json["HS_Pipeline"] == null
            ? null
            : CreatedAt.fromJson(json["HS_Pipeline"]),
        dType: json["dType"] == null ? null : CreatedAt.fromJson(json["dType"]),
        id: json["id"] == null ? null : CreatedAt.fromJson(json["id"]),
        createdAt: json["CreatedAt"] == null
            ? null
            : CreatedAt.fromJson(json["CreatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "HS_Pipeline": hsPipeline?.toJson(),
        "dType": dType?.toJson(),
        "id": id?.toJson(),
        "CreatedAt": createdAt?.toJson(),
      };
}

class CreatedAt {
  String? s;

  CreatedAt({
    this.s,
  });

  CreatedAt copyWith({
    String? s,
  }) =>
      CreatedAt(
        s: s ?? this.s,
      );

  factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
        s: json["S"],
      );

  Map<String, dynamic> toJson() => {
        "S": s,
      };
}

class Params {
  Params();

  Params copyWith() => Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}

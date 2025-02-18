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
  final num? failCode;
  final String? message;

  TicketClassificationResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  TicketClassificationResponseModel copyWith({
    Data? data,
    bool? success,
    num? failCode,
    String? message,
  }) =>
      TicketClassificationResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
      );

  factory TicketClassificationResponseModel.fromJson(
          Map<String, dynamic> json) =>
      TicketClassificationResponseModel(
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
  final num? pageSize;
  final dynamic lastEvaluatedKey;
  final num? currentPage;

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
    dynamic lastEvaluatedKey,
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
        lastEvaluatedKey: json["lastEvaluatedKey"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalRecords": totalRecords,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "pageSize": pageSize,
        "lastEvaluatedKey": lastEvaluatedKey,
        "currentPage": currentPage,
      };
}

class Item {
  final String? id;
  final DateTime? createdAt;
  final String? aiclassification;
  final String? classification;
  final bool? isUpdatedToHubspot;
  final String? reasoning;
  final String? ticketDescription;
  final String? bopsState;
  final String? classificationValidation;
  final String? classificationValidationReason;
  final String? validatedClassification;
  final String? classificationValidatedBy;

  Item({
    this.id,
    this.createdAt,
    this.aiclassification,
    this.classification,
    this.isUpdatedToHubspot,
    this.reasoning,
    this.ticketDescription,
    this.bopsState,
    this.classificationValidation,
    this.classificationValidationReason,
    this.validatedClassification,
    this.classificationValidatedBy,
  });

  Item copyWith({
    String? id,
    DateTime? createdAt,
    String? aiclassification,
    String? classification,
    bool? isUpdatedToHubspot,
    String? reasoning,
    String? ticketDescription,
    String? bopsState,
    String? classificationValidation,
    String? classificationValidationReason,
    String? validatedClassification,
    String? classificationValidatedBy,
  }) =>
      Item(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        aiclassification: aiclassification ?? this.aiclassification,
        classification: classification ?? this.classification,
        isUpdatedToHubspot: isUpdatedToHubspot ?? this.isUpdatedToHubspot,
        reasoning: reasoning ?? this.reasoning,
        ticketDescription: ticketDescription ?? this.ticketDescription,
        bopsState: bopsState ?? this.bopsState,
        classificationValidation:
            classificationValidation ?? this.classificationValidation,
        classificationValidationReason: classificationValidationReason ??
            this.classificationValidationReason,
        validatedClassification:
            validatedClassification ?? this.validatedClassification,
        classificationValidatedBy:
            classificationValidatedBy ?? this.classificationValidatedBy,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        createdAt: json["CreatedAt"] == null
            ? null
            : DateTime.parse(json["CreatedAt"]),
        aiclassification: json["AIClassification"],
        classification: json["classification"],
        isUpdatedToHubspot: json["isUpdatedToHubspot"],
        reasoning: json["reasoning"],
        ticketDescription: json["Ticket_Description"],
        bopsState: json["BOPS_State"],
        classificationValidation: json["classificationValidation"],
        classificationValidationReason: json["classificationValidationReason"],
        validatedClassification: json["validatedClassification"],
        classificationValidatedBy: json["classificationValidatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "CreatedAt": createdAt?.toIso8601String(),
        "classification": classification,
        "isUpdatedToHubspot": isUpdatedToHubspot,
        "reasoning": reasoning,
        "Ticket_Description": ticketDescription,
        "BOPS_State": bopsState,
        "classificationValidation": classificationValidation,
        "classificationValidationReason": classificationValidationReason,
        "validatedClassification": validatedClassification,
        "classificationValidatedBy": classificationValidatedBy,
      };
}

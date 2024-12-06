class DashboardAiQueryResponseModel {
  final Data? data;
  final bool? success;
  final int? failCode;
  final Params? params;
  final String? message;

  DashboardAiQueryResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  DashboardAiQueryResponseModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as Map<String, dynamic>?) != null
            ? Data.fromJson(json['data'] as Map<String, dynamic>)
            : null,
        success = json['success'] as bool?,
        failCode = json['failCode'] as int?,
        params = (json['params'] as Map<String, dynamic>?) != null
            ? Params.fromJson(json['params'] as Map<String, dynamic>)
            : null,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'success': success,
        'failCode': failCode,
        'params': params?.toJson(),
        'message': message
      };
}

class Data {
  final int? totalRecords;
  final List<Items>? items;
  final num? pageSize;
  final num? currentPage;
  final LastEvaluatedKey? lastEvaluatedKey;

  Data({
    this.totalRecords,
    this.items,
     required this.pageSize,
    required this.currentPage,
    this.lastEvaluatedKey,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalRecords: json["totalRecords"],
        items: json["items"] == null
            ? []
            : List<Items>.from(json["items"]!.map((x) => Items.fromJson(x))),
        lastEvaluatedKey: json["lastEvaluatedKey"] == null
            ? null
            : LastEvaluatedKey.fromJson(json["lastEvaluatedKey"]),
             pageSize: json["pageSize"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        'totalRecords': totalRecords,
        'items': items?.map((e) => e.toJson()).toList(),
        "lastEvaluatedKey": lastEvaluatedKey?.toJson(),
         "pageSize": pageSize,
        "currentPage": currentPage,
      };
}

class Items {
  final String? id;
  final String? createdAt;
  final String? ticketDescription;
  final String? aIResponse;
  final bool? answeredStatus;
  final bool? isAnswerEdited;
  final bool? agentAnsValidation;
  final String? answerValidationReason;

  Items({
    this.id,
    this.createdAt,
    this.ticketDescription,
    this.aIResponse,
    this.answeredStatus,
    this.isAnswerEdited,
    this.agentAnsValidation,
    this.answerValidationReason,
  });

  Items.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        createdAt = json['CreatedAt'] as String?,
        ticketDescription = json['Ticket_Description'] as String?,
        aIResponse = json['AI_Response'] as String?,
        isAnswerEdited = json['isAnswerEdited'] as bool?,
        agentAnsValidation = json['agentAnsValidation'] as bool?,
        answerValidationReason = json['answerValidationReason'] as String?,
        answeredStatus = json['answeredStatus'] as bool?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'CreatedAt': createdAt,
        'Ticket_Description': ticketDescription,
        'AI_Response': aIResponse,
        'answeredStatus': answeredStatus,
        'isAnswerEdited': isAnswerEdited,
        'agentAnsValidation': agentAnsValidation,
        'answerValidationReason': answerValidationReason
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

  factory LastEvaluatedKey.fromJson(Map<String, dynamic> json) =>
      LastEvaluatedKey(
        id: json["id"] == null ? null : CreatedAt.fromJson(json["id"]),
        dType: json["dType"] == null ? null : CreatedAt.fromJson(json["dType"]),
        createdAt: json["CreatedAt"] == null
            ? null
            : CreatedAt.fromJson(json["CreatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id?.toJson(),
        "dType": dType?.toJson(),
        "CreatedAt": createdAt?.toJson(),
      };
}

class CreatedAt {
  final String? s;

  CreatedAt({
    this.s,
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

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}

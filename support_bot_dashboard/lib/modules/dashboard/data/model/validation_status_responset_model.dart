// To parse this JSON data, do
//
//     final validationStatusResponsetModel = validationStatusResponsetModelFromJson(jsonString);

import 'dart:convert';

ValidationStatusResponsetModel validationStatusResponsetModelFromJson(String str) => ValidationStatusResponsetModel.fromJson(json.decode(str));

String validationStatusResponsetModelToJson(ValidationStatusResponsetModel data) => json.encode(data.toJson());

class ValidationStatusResponsetModel {
    final Data? data;
    final bool? success;
    final int? failCode;
    final Params? params;
    final String? message;

    ValidationStatusResponsetModel({
        this.data,
        this.success,
        this.failCode,
        this.params,
        this.message,
    });

    factory ValidationStatusResponsetModel.fromJson(Map<String, dynamic> json) => ValidationStatusResponsetModel(
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
    final AcknowledgementRequired? spamMarketing;
    final AcknowledgementRequired? genuineQuery;
    final AcknowledgementRequired? acknowledgementRequired;
    final AcknowledgementRequired? noActionRequired;

    Data({
        this.spamMarketing,
        this.genuineQuery,
        this.acknowledgementRequired,
        this.noActionRequired,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        spamMarketing: json["Spam/Marketing"] == null ? null : AcknowledgementRequired.fromJson(json["Spam/Marketing"]),
        genuineQuery: json["Genuine Query"] == null ? null : AcknowledgementRequired.fromJson(json["Genuine Query"]),
        acknowledgementRequired: json["Acknowledgement Required"] == null ? null : AcknowledgementRequired.fromJson(json["Acknowledgement Required"]),
        noActionRequired: json["No Action Required"] == null ? null : AcknowledgementRequired.fromJson(json["No Action Required"]),
    );

    Map<String, dynamic> toJson() => {
        "Spam/Marketing": spamMarketing?.toJson(),
        "Genuine Query": genuineQuery?.toJson(),
        "Acknowledgement Required": acknowledgementRequired?.toJson(),
        "No Action Required": noActionRequired?.toJson(),
    };
}

class AcknowledgementRequired {
    final int? spamMarketing;
    final int? genuineQuery;
    final int? acknowledgementRequired;
    final int? noActionRequired;

    AcknowledgementRequired({
        this.spamMarketing,
        this.genuineQuery,
        this.acknowledgementRequired,
        this.noActionRequired,
    });

    factory AcknowledgementRequired.fromJson(Map<String, dynamic> json) => AcknowledgementRequired(
        spamMarketing: json["Spam/Marketing"],
        genuineQuery: json["Genuine Query"],
        acknowledgementRequired: json["Acknowledgement Required"],
        noActionRequired: json["No Action Required"],
    );

    Map<String, dynamic> toJson() => {
        "Spam/Marketing": spamMarketing,
        "Genuine Query": genuineQuery,
        "Acknowledgement Required": acknowledgementRequired,
        "No Action Required": noActionRequired,
    };
}

class Params {
    Params();

    factory Params.fromJson(Map<String, dynamic> json) => Params(
    );

    Map<String, dynamic> toJson() => {
    };
}

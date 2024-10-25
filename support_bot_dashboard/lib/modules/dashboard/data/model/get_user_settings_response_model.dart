// To parse this JSON data, do
//
//     final getUserSettingsAttributeModel = getUserSettingsAttributeModelFromJson(jsonString);

import 'dart:convert';

GetUserSettingsResponseModel getUserSettingsResponseModelFromJson(String str) => GetUserSettingsResponseModel.fromJson(json.decode(str));

String getUserSettingsResponseModelToJson(GetUserSettingsResponseModel data) => json.encode(data.toJson());

class GetUserSettingsResponseModel {
    final Data? data;
    final bool? success;
    final int? failCode;
    final Params? params;
    final String? message;

    GetUserSettingsResponseModel({
        this.data,
        this.success,
        this.failCode,
        this.params,
        this.message,
    });

    factory GetUserSettingsResponseModel.fromJson(Map<String, dynamic> json) => GetUserSettingsResponseModel(
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
    final String? accessRole;

    Data({
        this.accessRole,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessRole: json["AccessRole"],
    );

    Map<String, dynamic> toJson() => {
        "AccessRole": accessRole,
    };
}

class Params {
    Params();

    factory Params.fromJson(Map<String, dynamic> json) => Params(
    );

    Map<String, dynamic> toJson() => {
    };
}

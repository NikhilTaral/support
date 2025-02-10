import 'dart:convert';

BOpsResponseModel bOpsResponseModelFromJson(String str) => BOpsResponseModel.fromJson(json.decode(str));

String bOpsResponseModelToJson(BOpsResponseModel data) => json.encode(data.toJson());

class BOpsResponseModel {
    final List<String>? data;
    final bool? success;
    final num? failCode;
    final Params? params;
    final String? message;

    BOpsResponseModel({
        this.data,
        this.success,
        this.failCode,
        this.params,
        this.message,
    });

    BOpsResponseModel copyWith({
        List<String>? data,
        bool? success,
        num? failCode,
        Params? params,
        String? message,
    }) => 
        BOpsResponseModel(
            data: data ?? this.data,
            success: success ?? this.success,
            failCode: failCode ?? this.failCode,
            params: params ?? this.params,
            message: message ?? this.message,
        );

    factory BOpsResponseModel.fromJson(Map<String, dynamic> json) => BOpsResponseModel(
        data: json["data"] == null ? [] : List<String>.from(json["data"]!.map((x) => x)),
        success: json["success"],
        failCode: json["failCode"],
        params: json["params"] == null ? null : Params.fromJson(json["params"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "success": success,
        "failCode": failCode,
        "params": params?.toJson(),
        "message": message,
    };
}

class Params {
    Params();

    Params copyWith() => 
        Params(
        );

    factory Params.fromJson(Map<String, dynamic> json) => Params(
    );

    Map<String, dynamic> toJson() => {
    };
}

import 'package:meta/meta.dart';
import 'dart:convert';

class GetValidationDetailsRequestModel {
    final String id;

    GetValidationDetailsRequestModel({
        required this.id,
    });

    GetValidationDetailsRequestModel copyWith({
        String? id,
    }) => 
        GetValidationDetailsRequestModel(
            id: id ?? this.id,
        );

    factory GetValidationDetailsRequestModel.fromRawJson(String str) => GetValidationDetailsRequestModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetValidationDetailsRequestModel.fromJson(Map<String, dynamic> json) => GetValidationDetailsRequestModel(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}

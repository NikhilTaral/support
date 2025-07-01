import 'dart:convert';

String getAiResponseStatRequestModelToJson(GetAiResponseStatRequestModel data) => json.encode(data.toJson());

class GetAiResponseStatRequestModel {
  final String? startDate;
  final String? endDate;
  final List<GetAiResponseStatFilter>? filter;

  GetAiResponseStatRequestModel({
    this.startDate,
    this.endDate,
    this.filter,
  });

  Map<String, dynamic> toJson() => {
        "startDate": startDate ?? "",
        "endDate": endDate ?? "",
        "filter": filter == null ? [] : List<dynamic>.from(filter!.map((x) => x.toJson())),
      };
}

class GetAiResponseStatFilter {
  final String? fieldName;
  final List<String>? fieldValue;

  GetAiResponseStatFilter({
    this.fieldName,
    this.fieldValue,
  });

  Map<String, dynamic> toJson() => {
        "fieldName": fieldName ?? "",
        "fieldValue": fieldValue == null ? [] : List<dynamic>.from(fieldValue!.map((x) => x)),
      };
}

class DashboardAiQueryEditedAttributeModel {
  AiQueryEditedData? data;
  bool? success;
  num? failCode;
  Params? params;
  String? message;

  DashboardAiQueryEditedAttributeModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });
}

class AiQueryEditedData {
  AiQueryEditedCounts? counts;
  AiQueryEditedCounts? percentages;

  AiQueryEditedData({
    this.counts,
    this.percentages,
  });
}

class AiQueryEditedCounts {
  num? editedCount;
  num? unEditedCount;

  AiQueryEditedCounts({
    this.editedCount,
    this.unEditedCount,
  });
}

class Params {
  Params();
}

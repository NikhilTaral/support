class AiAccuracyAndValidationTrendsAttributeModel {
  final DataAttribute? data;
  final bool? success;
  final num? failCode;
  final String? message;

  AiAccuracyAndValidationTrendsAttributeModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  AiAccuracyAndValidationTrendsAttributeModel copyWith({
     DataAttribute? data,
    bool? success,
    num? failCode,
    String? message,
  }) =>
      AiAccuracyAndValidationTrendsAttributeModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
      );
}

class DataAttribute {
  final List<AttributeItem>? items;

  DataAttribute({
    this.items,
  });

  DataAttribute copyWith({
    List<AttributeItem>? items,
  }) =>
      DataAttribute(
        items: items ?? this.items,
      );
}

class AttributeItem {
  final String? date;
  final num? aiAccuracy;
  final num? validationPercentage;

  AttributeItem({
    this.date,
    this.aiAccuracy,
    this.validationPercentage,
  });

  AttributeItem copyWith({
    String? date,
    num? aiAccuracy,
    num? validationPercentage,
  }) =>
      AttributeItem(
        date: date ?? this.date,
        aiAccuracy: aiAccuracy ?? this.aiAccuracy,
        validationPercentage: validationPercentage ?? this.validationPercentage,
      );
}

class GetValidationDetailsAttributeModel {
  final Data? data;
  final bool? success;
  final int? failCode;
  final String? message;

  GetValidationDetailsAttributeModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  GetValidationDetailsAttributeModel copyWith({
    Data? data,
    bool? success,
    int? failCode,
    String? message,
  }) =>
      GetValidationDetailsAttributeModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
      );
}

class Data {
  final String? message;
  final bool? status;

  Data({
    this.message,
    this.status,
  });

  Data copyWith({
    String? message,
    bool? status,
  }) =>
      Data(
        message: message ?? this.message,
        status: status ?? this.status,
      );
}

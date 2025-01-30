class RevortEntitieModel {
  final Data? data;
  final bool? success;
  final num? failCode;
  final String? message;

  RevortEntitieModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  RevortEntitieModel copyWith({
    Data? data,
    bool? success,
    num? failCode,
    String? message,
  }) =>
      RevortEntitieModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
      );
}

class Data {
  final String? message;

  Data({
    this.message,
  });

  Data copyWith({
    String? message,
  }) =>
      Data(
        message: message ?? this.message,
      );
}

class BOpsResponseAttributeModel {
  final List<String>? data;
  final bool? success;
  final num? failCode;
  final Params? params;
  final String? message;

  BOpsResponseAttributeModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  BOpsResponseAttributeModel copyWith({
    List<String>? data,
    bool? success,
    num? failCode,
    Params? params,
    String? message,
  }) =>
      BOpsResponseAttributeModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        params: params ?? this.params,
        message: message ?? this.message,
      );
}

class Params {
  Params();

  Params copyWith() => Params();
}

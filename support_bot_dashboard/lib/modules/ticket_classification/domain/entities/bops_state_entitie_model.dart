class BOpsResponseEntitieModel {
  final List<String>? data;
  final bool? success;
  final num? failCode;
  final Params? params;
  final String? message;

  BOpsResponseEntitieModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  BOpsResponseEntitieModel copyWith({
    List<String>? data,
    bool? success,
    num? failCode,
    Params? params,
    String? message,
  }) =>
      BOpsResponseEntitieModel(
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

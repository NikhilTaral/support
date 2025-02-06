class UpdateClassificationValidationAttributeModule {
    final Data? data;
    final bool? success;
    final num? failCode;
    final String? message;

    UpdateClassificationValidationAttributeModule({
        this.data,
        this.success,
        this.failCode,
        this.message,
    });

    UpdateClassificationValidationAttributeModule copyWith({
        Data? data,
        bool? success,
        num? failCode,
        String? message,
    }) => 
        UpdateClassificationValidationAttributeModule(
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

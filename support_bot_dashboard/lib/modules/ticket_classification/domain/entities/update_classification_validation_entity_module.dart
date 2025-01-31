class UpdateClassificationValidationEntitieModule {
    final Data? data;
    final bool? success;
    final num? failCode;
    final String? message;

    UpdateClassificationValidationEntitieModule({
        this.data,
        this.success,
        this.failCode,
        this.message,
    });

    UpdateClassificationValidationEntitieModule copyWith({
        Data? data,
        bool? success,
        num? failCode,
        String? message,
    }) => 
        UpdateClassificationValidationEntitieModule(
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

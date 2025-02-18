class GetValidationDetailsAttributeModel {
    final ValidationData? data;

    GetValidationDetailsAttributeModel({
        this.data,
    });

}

class ValidationData {
    final String? message;
    final bool? status;

    ValidationData({
        this.message,
        this.status,
    });

}

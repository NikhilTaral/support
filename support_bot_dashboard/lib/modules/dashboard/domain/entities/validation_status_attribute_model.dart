class ValidationStatusAttributeModel {
  final Datas? data;
  final bool? success;
  final num? failCode;
  final Params? params;
  final String? message;

  ValidationStatusAttributeModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  ValidationStatusAttributeModel copyWith({
    Datas? data,
    bool? success,
    num? failCode,
    Params? params,
    String? message,
  }) =>
      ValidationStatusAttributeModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        params: params ?? this.params,
        message: message ?? this.message,
      );
}

class Datas {
  final AcknowledgementRequiredAttribute? spamMarketing;
  final AcknowledgementRequiredAttribute? genuineQuery;
  final AcknowledgementRequiredAttribute? acknowledgementRequired;
  final AcknowledgementRequiredAttribute? noActionRequired;

  Datas({
    this.spamMarketing,
    this.genuineQuery,
    this.acknowledgementRequired,
    this.noActionRequired,
  });

  Datas copyWith({
    AcknowledgementRequiredAttribute? spamMarketing,
    AcknowledgementRequiredAttribute? genuineQuery,
    AcknowledgementRequiredAttribute? acknowledgementRequired,
    AcknowledgementRequiredAttribute? noActionRequired,
  }) =>
      Datas(
        spamMarketing: spamMarketing ?? this.spamMarketing,
        genuineQuery: genuineQuery ?? this.genuineQuery,
        acknowledgementRequired:
            acknowledgementRequired ?? this.acknowledgementRequired,
        noActionRequired: noActionRequired ?? this.noActionRequired,
      );
}

class AcknowledgementRequiredAttribute {
  final num? spamMarketing;
  final num? genuineQuery;
  final num? acknowledgementRequired;
  final num? noActionRequired;

  AcknowledgementRequiredAttribute({
    this.spamMarketing,
    this.genuineQuery,
    this.acknowledgementRequired,
    this.noActionRequired,
  });

  AcknowledgementRequiredAttribute copyWith({
    num? spamMarketing,
    num? genuineQuery,
    num? acknowledgementRequired,
    num? noActionRequired,
  }) =>
      AcknowledgementRequiredAttribute(
        spamMarketing: spamMarketing ?? this.spamMarketing,
        genuineQuery: genuineQuery ?? this.genuineQuery,
        acknowledgementRequired:
            acknowledgementRequired ?? this.acknowledgementRequired,
        noActionRequired: noActionRequired ?? this.noActionRequired,
      );
}

class Params {
  Params();

  Params copyWith() => Params();
}

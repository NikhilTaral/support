import 'package:support_bot_dashboard/modules/dashboard/data/model/validation_status_responset_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/validation_status_attribute_model.dart';

class AttributeMapper {
  static ValidationStatusAttributeModel mapValidationStatuseResponseModel(
      ValidationStatusResponsetModel? model) {
    return ValidationStatusAttributeModel(data: mapDatas(model?.data));
  }

  static Datas mapDatas(Data? data) {
    return Datas(
      acknowledgementRequired:
          mapAcknowledgementRequiredAttribute(data?.acknowledgementRequired),
      genuineQuery: mapAcknowledgementRequiredAttribute(data?.genuineQuery),
      noActionRequired:
          mapAcknowledgementRequiredAttribute(data?.noActionRequired),
      spamMarketing: mapAcknowledgementRequiredAttribute(data?.spamMarketing),
    );
  }

  static AcknowledgementRequiredAttribute mapAcknowledgementRequiredAttribute(
      AcknowledgementRequired? acknowledgementRequired) {
    return AcknowledgementRequiredAttribute(
        acknowledgementRequired:
            acknowledgementRequired?.acknowledgementRequired,
        genuineQuery: acknowledgementRequired?.genuineQuery,
        noActionRequired: acknowledgementRequired?.noActionRequired,
        spamMarketing: acknowledgementRequired?.spamMarketing);
  }
}

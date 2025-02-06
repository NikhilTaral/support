import 'package:support_bot_dashboard/modules/dashboard/data/model/get_all_pipelines_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/validation_status_responset_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
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

  static GetAllPipelinesAttributeModel mapGetAllPipelinesAttributeModel(
      GetAllPipelinesResponsetModel? model) {
    return GetAllPipelinesAttributeModel(
        data: model?.data
                ?.map((e) => Datums(
                    aiAnswerPerm: e.aiAnswerPerm ?? true,
                    hubspotUpdateEnv: e.hubspotUpdateEnv ?? "",
                    hubspotUpdatepPerm: e.hubspotUpdatepPerm ?? true,
                    pipelineId: e.pipelineId ?? "",
                    pipelineName: e.pipelineName ?? ""))
                .toList() ??
            []);
  }

  static List<Datums>? mapData(List<Datum>? data) {
    return data
        ?.map((datum) => Datums(
              aiAnswerPerm: datum.aiAnswerPerm,
              hubspotUpdateEnv: datum.hubspotUpdateEnv ?? "",
              hubspotUpdatepPerm: datum.hubspotUpdatepPerm,
              pipelineId: datum.pipelineId ?? "",
              pipelineName: datum.pipelineName ?? "",
            ))
        .toList();
  }
}

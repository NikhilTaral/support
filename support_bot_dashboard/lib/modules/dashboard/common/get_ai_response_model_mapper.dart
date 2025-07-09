import 'package:support_bot_dashboard/modules/dashboard/data/model/get_ai_response_stat_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_ai_response_stat_attribute_model.dart';

extension GetAiResponseStatMapper on GetAiResponseStatResonseModel {
  GetAiResponseStatAttributeModel toAttributeModel() {
    return GetAiResponseStatAttributeModel(
      counts: counts?.toCountsModel(),
      percentages: percentages?.toCountsModel(),
    );
  }
}

extension GetAiResponseCountsMapper on GetAiResponseCounts {
  CountsAttribute toCountsModel() {
    return CountsAttribute(
      totalTickets: totalTickets?.toDouble() ?? 0,
      totalResponses: totalResponses?.toDouble() ?? 0,
      validatedResponses: validatedResponses?.toDouble() ?? 0,
      correctResponses: correctResponses?.toDouble() ?? 0,
      incorrectResponses: incorrectResponses?.toDouble() ?? 0,
      needsImprovement: needsImprovement?.toDouble() ?? 0,
    );
  }
}

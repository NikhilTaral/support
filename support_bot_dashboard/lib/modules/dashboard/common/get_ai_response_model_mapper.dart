import 'package:support_bot_dashboard/modules/dashboard/data/model/get_ai_response_stat_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_ai_response_stat_attribute_model.dart';

extension GetAiResponseStatMapper on GetAiResponseStat {
  GetAiResponseStatAttributeModel toAttributeModel() {
    return GetAiResponseStatAttributeModel(
      counts: counts?.toCountsModel(),
      percentages: percentages?.toCountsModel(),
    );
  }
}

extension GetAiResponseCountsMapper on GetAiResponseCounts {
  Counts toCountsModel() {
    return Counts(
      totalTickets: totalTickets?.toInt() ?? 0,
      totalResponses: totalResponses?.toInt() ?? 0,
      validatedResponses: validatedResponses ?? 0,
      correctResponses: correctResponses ?? 0,
      incorrectResponses: incorrectResponses ?? 0,
      needsImprovement: needsImprovement ?? 0,
    );
  }
}

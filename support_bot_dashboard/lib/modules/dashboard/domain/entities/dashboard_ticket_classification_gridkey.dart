

import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';

class TicketClassificationGridKey {
  static const String id = "id";
  static const String classification = "classification";
  static const String reasoning = "reasoning";
  static const String ticketDescription = "ticketDescription";
  static const String validation = "validation";
  static const String validationReason = "validation_reason";
  static const String isUpdatedToHubspot = "isUpdatedToHubspot";
  static const String status = "status";
  static const String actions = "actions";

  static String getTitle(String key) {
    final s = serviceLocator<S>();
    switch (key) {
      case TicketClassificationGridKey.id:
        return s.id;
      case TicketClassificationGridKey.classification:
        return s.classification;
      case TicketClassificationGridKey.reasoning:
        return s.reasoning;
      case TicketClassificationGridKey.ticketDescription:
        return s.ticketDescription;
      case TicketClassificationGridKey.validation:
        return s.validation;
      case TicketClassificationGridKey.validationReason:
        return s.validationReason;
      case TicketClassificationGridKey.status:
        return s.status;
      default:
        return "";
    }
  }
}

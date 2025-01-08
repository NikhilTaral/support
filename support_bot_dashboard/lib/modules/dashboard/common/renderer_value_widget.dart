import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';

class Renderer {
  static Widget textRenderer(PlutoColumnRendererContext rendererContext) {
    final columnName = rendererContext.column.title;
    final firstCell = rendererContext.row.cells.entries.first.value;
    final firstCellValue = firstCell.value;
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: getColors(colString: columnName, rowString: firstCellValue),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Text(
          rendererContext.cell.value.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

Color getColors({required String? colString, required String? rowString}) {
  String? colTitle =
      RequestMentorReportKeys.getTitle(RequestMentorReportKeys.genuineQuery);
  String? rowTitleAck =
      RequestMentorReportKeys.getTitle(RequestMentorReportKeys.ackRequired);
  String? rowTitleNoAction = RequestMentorReportKeys.getTitle(
      RequestMentorReportKeys.noActionRequired);
  String? rowTitleSpam =
      RequestMentorReportKeys.getTitle(RequestMentorReportKeys.spam);

  if (colString == colTitle && rowString == rowTitleAck ||
      colString == rowTitleAck && rowString == colTitle ||
      colString == rowTitleSpam && rowString == rowTitleNoAction ||
      rowString == rowTitleSpam && colString == rowTitleNoAction) {
    return Colors.orange.withOpacity(0.5);
  } else if (colString == rowString) {
    return Colors.green.withOpacity(0.5);
  } else if (colString ==
      RequestMentorReportKeys.getTitle(
          RequestMentorReportKeys.aIClassification)) {
    return Colors.transparent;
  } else {
    return Colors.red.withOpacity(0.3);
  }
}

class RequestMentorReportKeys {
  static const String aIClassification = "ai_classification";
  static const String genuineQuery = 'genuine_query';
  static const String ackRequired = 'ack_required';
  static const String noActionRequired = 'no_action_required';
  static const String spam = 'spam';

  static String getTitle(String key) {
    final s = serviceLocator<S>();
    switch (key) {
      case RequestMentorReportKeys.aIClassification:
        return s.aIClassification;
      case RequestMentorReportKeys.genuineQuery:
        return s.genuineQuery;
      case RequestMentorReportKeys.ackRequired:
        return s.ackRequired;
      case RequestMentorReportKeys.noActionRequired:
        return s.noActionRequired;
      case RequestMentorReportKeys.spam:
        return s.spam;

      default:
        return "";
    }
  }
}

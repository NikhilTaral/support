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
        ),
        padding: const EdgeInsets.all(8.0),
        child: Text(
          overflow: TextOverflow.ellipsis,
          rendererContext.cell.value.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

Color getColors({required String? colString, required String? rowString}) {
  String? colTitle = RequestMentorReportKeys.getTitle(RequestMentorReportKeys.genuineQuery);
  String? rowTitleAck = RequestMentorReportKeys.getTitle(RequestMentorReportKeys.ackRequired);
  String? rowTitleNoAction = RequestMentorReportKeys.getTitle(RequestMentorReportKeys.noActionRequired);
  String? rowTitleSpam = RequestMentorReportKeys.getTitle(RequestMentorReportKeys.spam);

  if (colString == colTitle && rowString == rowTitleAck ||
      colString == rowTitleAck && rowString == colTitle ||
      colString == rowTitleSpam && rowString == rowTitleNoAction ||
      rowString == rowTitleSpam && colString == rowTitleNoAction) {
    return const Color(0xFFFFE3E9);
  } else if (colString == rowString) {
    return const Color(0xFFE9F8E9);
  } else if (colString == RequestMentorReportKeys.getTitle(RequestMentorReportKeys.aIClassification)) {
    return Colors.transparent;
  } else {
    return const Color(0xFFFFE3E9);
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
        return s.acknowledgeRequiredText;
      case RequestMentorReportKeys.noActionRequired:
        return s.noActionRequired;
      case RequestMentorReportKeys.spam:
        return s.spam;

      default:
        return "";
    }
  }
}

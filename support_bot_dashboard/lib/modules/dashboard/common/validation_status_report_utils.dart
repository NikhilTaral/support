import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/common/renderer_value_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/validation_status_attribute_model.dart';

class ValidationStatusReportUtils {
  static List<PlutoColumn> validationStatusColumns() {
    return [
      PlutoColumn(
        title: RequestMentorReportKeys.getTitle(
            RequestMentorReportKeys.aIClassification),
        field: RequestMentorReportKeys.aIClassification,
        type: PlutoColumnType.text(),
        renderer: Renderer.textRenderer,
        sort: PlutoColumnSort.none,
        enableSorting: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
      ),
      PlutoColumn(
        title: RequestMentorReportKeys.getTitle(
            RequestMentorReportKeys.genuineQuery),
        field: RequestMentorReportKeys.genuineQuery,
        type: PlutoColumnType.number(),
        renderer: Renderer.textRenderer,
        enableSorting: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
      ),
      PlutoColumn(
        title: RequestMentorReportKeys.getTitle(
            RequestMentorReportKeys.ackRequired),
        field: RequestMentorReportKeys.ackRequired,
        type: PlutoColumnType.number(),
        renderer: Renderer.textRenderer,
        enableSorting: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
      ),
      PlutoColumn(
        title: RequestMentorReportKeys.getTitle(
            RequestMentorReportKeys.noActionRequired),
        field: RequestMentorReportKeys.noActionRequired,
        type: PlutoColumnType.number(),
        renderer: Renderer.textRenderer,
        enableSorting: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
      ),
      PlutoColumn(
        title: RequestMentorReportKeys.getTitle(RequestMentorReportKeys.spam),
        field: RequestMentorReportKeys.spam,
        type: PlutoColumnType.number(),
        renderer: Renderer.textRenderer,
        enableSorting: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
      ),
    ];
  }

  static List<PlutoRow> validationStatusRow({
    required ValidationStatusAttributeModel? attributeModel,
  }) {
    List<PlutoRow> rows = [];
    final model = attributeModel?.data;
    final s = serviceLocator<S>();

    rows.add(
      PlutoRow(cells: {
        RequestMentorReportKeys.aIClassification:
            PlutoCell(value: s.genuineQueryText),
        RequestMentorReportKeys.genuineQuery: PlutoCell(
          value: model?.genuineQuery?.genuineQuery ?? 0,
        ),
        RequestMentorReportKeys.ackRequired:
            PlutoCell(value: model?.genuineQuery?.acknowledgementRequired ?? 0),
        RequestMentorReportKeys.noActionRequired:
            PlutoCell(value: model?.genuineQuery?.noActionRequired ?? 0),
        RequestMentorReportKeys.spam:
            PlutoCell(value: model?.genuineQuery?.spamMarketing ?? 0),
      }),
    );
    rows.add(
      PlutoRow(cells: {
        RequestMentorReportKeys.aIClassification:
            PlutoCell(value: s.acknowledgeRequiredText),
        RequestMentorReportKeys.genuineQuery:
            PlutoCell(value: model?.acknowledgementRequired?.genuineQuery ?? 0),
        RequestMentorReportKeys.ackRequired: PlutoCell(
            value:
                model?.acknowledgementRequired?.acknowledgementRequired ?? 0),
        RequestMentorReportKeys.noActionRequired: PlutoCell(
            value: model?.acknowledgementRequired?.noActionRequired ?? 0),
        RequestMentorReportKeys.spam: PlutoCell(
            value: model?.acknowledgementRequired?.spamMarketing ?? 0),
      }),
    );
    rows.add(
      PlutoRow(cells: {
        RequestMentorReportKeys.aIClassification:
            PlutoCell(value: s.noActionRequired),
        RequestMentorReportKeys.genuineQuery:
            PlutoCell(value: model?.noActionRequired?.genuineQuery ?? 0),
        RequestMentorReportKeys.ackRequired: PlutoCell(
            value: model?.noActionRequired?.acknowledgementRequired ?? 0),
        RequestMentorReportKeys.noActionRequired:
            PlutoCell(value: model?.noActionRequired?.noActionRequired ?? 0),
        RequestMentorReportKeys.spam:
            PlutoCell(value: model?.noActionRequired?.spamMarketing ?? 0),
      }),
    );
    rows.add(
      PlutoRow(cells: {
        RequestMentorReportKeys.aIClassification:
            PlutoCell(value: s.spamMarketing),
        RequestMentorReportKeys.genuineQuery:
            PlutoCell(value: model?.spamMarketing?.genuineQuery ?? 0),
        RequestMentorReportKeys.ackRequired: PlutoCell(
            value: model?.spamMarketing?.acknowledgementRequired ?? 0),
        RequestMentorReportKeys.noActionRequired:
            PlutoCell(value: model?.spamMarketing?.noActionRequired ?? 0),
        RequestMentorReportKeys.spam:
            PlutoCell(value: model?.spamMarketing?.spamMarketing ?? 0),
      }),
    );
    return rows;
  }
}

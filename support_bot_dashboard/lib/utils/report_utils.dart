import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/ticket_classification_entitie_model.dart';
import 'package:support_bot_dashboard/utils/renderers.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';

class ReportUtils {
  ReportUtils(
      {this.context,
      TicketClassificationEntitieModel? ticketClassificationEntitieModel}) {
    this.ticketClassificationEntitieModel =
        ticketClassificationEntitieModel ?? TicketClassificationEntitieModel();
  }
  final s = serviceLocator<S>();
  late TicketClassificationEntitieModel ticketClassificationEntitieModel;
  BuildContext? context;

  List<PlutoColumn> createTicketClassificationColumn(
      {required BuildContext context}) {
    return [
      PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'ID',
        field: "id",
        type: PlutoColumnType.text(),
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false,
        renderer: Renderers.textRenderer,
      ),
      PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'Ticket Description',
        field: "ticket_description",
        type: PlutoColumnType.text(),
        renderer: Renderers.tooltip,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false,
      ),
      PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'BOps State',
        field: 'bops_state',
        type: PlutoColumnType.text(),
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false,
        renderer: Renderers.textRenderer,
      ),
      PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'Classification',
        field: "classification",
        type: PlutoColumnType.text(),
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false,
        renderer: Renderers.textRenderer,
      ),
      PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'Validation',
        field: 'validation',
        type: PlutoColumnType.select(['Validated', 'Invalidated', 'Select']),
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false,

        // renderer: Renderers.applicationTextStatusRenderer,
      ),
      PlutoColumn(
          backgroundColor: SupportBotColors.disablePrimary.shade100,
          title: 'Status',
          field: 'status',
          type: PlutoColumnType.text(),
          enableAutoEditing: false,
          enableColumnDrag: false,
          enableContextMenu: false,
          enableFilterMenuItem: false,
          enableSorting: false,
          enableDropToResize: false,
          renderer: Renderers.applicationTextStatusRenderer),
      PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'Action',
        field: 'action',
        type: PlutoColumnType.text(),
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false,
        renderer: (rendererContext) => Renderers.actionButtonRenderer(
          rendererContext,
          context: context,
       
        ),
      ),
    ];
  }

  List<PlutoRow> createTicketClassificationRow() {
    final s = serviceLocator<S>();
    return ticketClassificationEntitieModel.data?.items
            ?.map((e) => PlutoRow(cells: {
                  "id": PlutoCell(
                    value: e.id ?? "NA",
                  ),
                  "ticket_description": PlutoCell(
                    value: e.ticketDescription ?? [],
                  ),
                  "bops_state": PlutoCell(
                    value: e.bopsState ?? "N/A",
                  ),
                  "classification": PlutoCell(
                    value: e.classification ?? "N/A",
                  ),
                  "validation": PlutoCell(
                    value: e.classificationValidation ?? "N/A",
                  ),
                  "status": PlutoCell(
                    value: e.isUpdatedToHubspot ?? "N/A",
                  ),
                  "action": PlutoCell(
                    value: {e.classificationValidatedBy ?? "N/A"},
                  ),
                }))
            .toList() ??
        [];
  }
}

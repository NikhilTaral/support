import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/domain/entities/ai_query_answer_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/ticket_classification_entitie_model.dart';
import 'package:support_bot_dashboard/utils/renderers.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';

class ReportUtils {
  ReportUtils(
      {this.context,
      TicketClassificationEntitieModel? ticketClassificationEntitieModel,
      AiQueryAttributeModel? aiQueryAttributeModel}) {
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
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false,
        renderer: Renderers.validationDropDown,
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
        renderer: Renderers.textRenderer,
      ),
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
        renderer: (rendererContext) =>
            Renderers.ticketClassificationActionRenderer(
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
                    value: e.isUpdatedToHubspot ?? "N/A",
                  ),
                  "status": PlutoCell(
                    value: e.classificationValidation ?? "N/A",
                  ),
                  "action": PlutoCell(
                    value: {
                      "validatedBy": e.classificationValidatedBy,
                    },
                  ),
                }))
            .toList() ??
        [];
  }

  List<PlutoColumn> createAIQueryEditedColumn({required BuildContext context}) {
    return [
      PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'ID',
        field: "id",
        width: 211,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.start,
        enableAutoEditing: false,
        enableEditingMode: false,
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
        width: 503,
        field: "ticket_description",
        type: PlutoColumnType.text(),
        renderer: Renderers.tooltip,
        titleTextAlign: PlutoColumnTextAlign.start,
        enableAutoEditing: false,
        enableEditingMode: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false,
      ),
      PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'Classification',
        field: "classification",
        width: 258,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.start,
        enableEditingMode: false,
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
          title: 'Validation Status',
          field: 'validation_status',
          width: 297,
          hide: true,
          type: PlutoColumnType.text(),
          titleTextAlign: PlutoColumnTextAlign.start,
          enableEditingMode: false,
          enableAutoEditing: false,
          enableColumnDrag: false,
          enableContextMenu: false,
          enableFilterMenuItem: false,
          enableSorting: false,
          enableDropToResize: false,
          renderer: Renderers.textRenderer),
      PlutoColumn(
          backgroundColor: SupportBotColors.disablePrimary.shade100,
          title: 'AI Query Answer',
          field: 'ai_query_answer',
          width: 297,
          type: PlutoColumnType.text(),
          titleTextAlign: PlutoColumnTextAlign.start,
          enableEditingMode: false,
          enableAutoEditing: false,
          enableColumnDrag: false,
          enableContextMenu: false,
          enableFilterMenuItem: false,
          enableSorting: false,
          enableDropToResize: false,
          renderer: Renderers.textRenderer),
      PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'Action',
        field: 'action',
        width: 111,
        textAlign: PlutoColumnTextAlign.end,
        titleTextAlign: PlutoColumnTextAlign.start,
        type: PlutoColumnType.text(),
        enableEditingMode: false,
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

  List<PlutoRow> createAIQueryEditedRow(
      {required AiQueryAttributeModel aiQueryAttributeModel}) {
    if (aiQueryAttributeModel.data == null ||
        aiQueryAttributeModel.data!.items == null) {
      return [];
    }

    return aiQueryAttributeModel.data?.items?.map((item) {
          return PlutoRow(
            cells: {
              'id': PlutoCell(value: item.id ?? ''),
              'ticket_description': PlutoCell(
                  value: item.ticketDescription?.replaceAll('\n', ' ') ?? ''),
              'classification': PlutoCell(
                  value: item.answeredStatus == "true"
                      ? 'Answered'
                      : 'Not Answered'),
              'validation_status': PlutoCell(
                  value: item.answeredStatus == true
                      ? "Validated"
                      : "Not Validated"),
              'ai_query_answer': PlutoCell(value: item.aiResponse ?? ''),
              'action': PlutoCell(value: '...')
            },
          );
        }).toList() ??
        [];
  }
}

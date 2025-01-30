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
      {required BuildContext context, required List<String> pipelineId}) {
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
        readOnly: true,
        enableSorting: false,
        enableEditingMode: false,
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
        readOnly: true,
        enableEditingMode: false,
        enableSorting: false,
        enableDropToResize: false,
      ),
      PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'BOPS State/ Province ',
        field: 'bops_state',
        type: PlutoColumnType.text(),
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
        readOnly: true,
        enableSorting: false,
        enableDropToResize: false,
        renderer: Renderers.textRenderer,
      ),
      PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'AI Classification',
        field: "aIclassification",
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
        title: 'Validated Classification',
        field: "classification",
        type: PlutoColumnType.text(),
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableEditingMode: false,
        readOnly: true,
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
        readOnly: true,
        enableSorting: false,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableDropToResize: false,
        renderer: (rendererContext) => Renderers.validationDropDown(
            rendererContext,
            piplineid: pipelineId),
      ),
      PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        readOnly: true,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableEditingMode: false,
        enableDropToResize: false,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: Renderers.statusRenderer,
      ),
      PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'Action',
        field: 'action',
        type: PlutoColumnType.text(),
        enableAutoEditing: false,
        enableColumnDrag: false,
        readOnly: true,
        enableContextMenu: false,
        enableEditingMode: false,
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
    List<PlutoRow> rows = [];
    for (int i = 0;
        i < (ticketClassificationEntitieModel.data?.items ?? []).length;
        i++) {
      final e = ticketClassificationEntitieModel.data?.items?[i];
      rows.add(PlutoRow(cells: {
        "id": PlutoCell(
          value: e?.id ?? "NA",
        ),
        'ticket_description':
            PlutoCell(value: e?.ticketDescription?.replaceAll('\n', ' ') ?? ''),
        "bops_state": PlutoCell(
          value: e?.bopsState ?? "N/A",
        ),
        "classification": PlutoCell(
          value: e?.classification ?? "N/A",
        ),
        "aIclassification": PlutoCell(
          value: e?.aiclassification ?? "N/A",
        ),
        "reasoning": PlutoCell(
          value: e?.reasoning ?? "N/A",
        ),
        "validation": PlutoCell(
          value: capitalizeFirstLetter(e?.classificationValidation ?? "-"),
        ),
        "status": PlutoCell(
          value: e?.isUpdatedToHubspot ?? "N/A",
        ),
        "Validation Reason": PlutoCell(
          value: e?.classificationValidationReason ?? "N/A",
        ),
        "action": PlutoCell(
          value: {
            "allRows": (ticketClassificationEntitieModel.data?.items ?? []),
            "validatedBy": e?.classificationValidatedBy,
            "isUpdatedToHubspot": e?.isUpdatedToHubspot,
            "index": i,
          },
        ),
        "validatedBy": PlutoCell(
          value: e?.classificationValidatedBy ?? "N/A",
        ),
      }));
    }
    return rows;
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
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
        renderer: (rendererContext) {
          final value = rendererContext.cell.value;
          if (value is Map<String, Object>) {
            final id = value['id']?.toString() ?? 'N/A';
            final isAnswerEdited = value['isAnswerEdited']?.toString() ?? 'N/A';

            return Wrap(
              spacing: 10,
              children: [
                Text(id),
                if (isAnswerEdited == "Edited")
                  Container(
                    constraints: const BoxConstraints(maxWidth: 70),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: SupportBotColors.bluePrimary.shade500,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        isAnswerEdited,
                        style: const TextStyle(color: SupportBotColors.white),
                      ),
                    ),
                  ),
              ],
            );
          }
          return Text(value?.toString() ?? 'N/A');
        },
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
        suppressedAutoSize: false,
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
          renderer: Renderers.tooltip),
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

  List<PlutoRow> createAIQueryEditedRow({
    required AiQueryAttributeModel aiQueryAttributeModel,
  }) {
    List<PlutoRow> rows = [];

    if (aiQueryAttributeModel.data == null ||
        aiQueryAttributeModel.data!.items == null) {
      return rows;
    }

    for (int i = 0; i < aiQueryAttributeModel.data!.items!.length; i++) {
      final e = aiQueryAttributeModel.data!.items![i];

      rows.add(
        PlutoRow(
          cells: {
            "id": PlutoCell(
              value: {
                "id": e.id ?? "N/A",
                "isAnswerEdited":
                    e.isAnswerEdited == true ? "Edited" : "Not Edited",
              },
            ),
            "ticket_description": PlutoCell(
              value: e.ticketDescription?.replaceAll('\n', ' ') ?? "",
            ),
            "classification": PlutoCell(
              value: e.answeredStatus == "true" ? "Answered" : "Not Answered",
            ),
            "validation_status": PlutoCell(
              value: e.answeredStatus == "true" ? "Validated" : "Not Validated",
            ),
            "ai_query_answer": PlutoCell(
              value: e.aiResponse ?? "N/A",
            ),
            "action": PlutoCell(
              value: {
                "allRows": aiQueryAttributeModel.data!.items!,
                "index": i,
                "isAnswerEdited": e.isAnswerEdited,
                "answeredStatus": e.answeredStatus,
              },
            ),
          },
        ),
      );
    }

    return rows;
  }
}

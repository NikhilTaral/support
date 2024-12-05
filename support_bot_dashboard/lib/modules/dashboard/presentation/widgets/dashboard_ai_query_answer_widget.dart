import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_answer/ai_query_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/custom_pagination_dropdown.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class AIQueryAnswerWidget extends StatelessWidget {
  final DashboardAiQueryAttributeModel aiQuerytableData;
  final DateTime? selectedMonth;
  final DateTime? selectedDate;
  String? pipeline;
  String? pipelineId;
  final ValueNotifier<int> currentPage;
  final ValueNotifier<int> pageSize;
  bool? isAnswer;
  AIQueryAnswerWidget(
      {super.key,
      required this.aiQuerytableData,
      this.pipeline,
      required this.selectedMonth,
      required this.selectedDate,
      required this.currentPage,
      required this.pageSize,
      required this.isAnswer,
      required this.pipelineId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: UIHelpers.screenHeight(context) * 0.4,
            child: PlutoGrid(
              columns: [
                PlutoColumn(
                  title: S.of(context).id,
                  field: 'id',
                  width: UIHelpers.screenWidth(context) * 0.13,
                  type: PlutoColumnType.text(),
                  enableFilterMenuItem: false,
                  enableHideColumnMenuItem: false,
                  textAlign: PlutoColumnTextAlign.start,
                  titlePadding: const EdgeInsets.all(8),
                  backgroundColor: SupportBotColors.blueSecondary.shade100,
                  enableContextMenu: false,
                  enableDropToResize: false,
                  enableEditingMode: false,
                  enableColumnDrag: false,
                  readOnly: true,
                  renderer: (rendererContext) {
                    final value = rendererContext.cell.value;

                    if (value is Map<String, Object>) {
                      final id = value['id']?.toString() ?? 'N/A';
                      final isAnswerEdited =
                          value['isAnswerEdited']?.toString() ?? 'N/A';

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(id),
                          UIHelpers.horizontalSpaceSmall,
                          if (isAnswerEdited == 'Edited')
                            Container(
                                width: UIHelpers.screenWidth(context) * 0.04,
                                height: UIHelpers.screenHeight(context) * 0.03,
                                decoration: BoxDecoration(
                                    color:
                                        SupportBotColors.bluePrimary.shade500,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(isAnswerEdited,
                                      style: const TextStyle(
                                          color: SupportBotColors.white)),
                                )),
                        ],
                      );
                    }
                    return Text(value?.toString() ?? 'N/A');
                  },
                ),
                PlutoColumn(
                  title: S.of(context).ticketDescription,
                  field: 'ticketDescription',
                  width: UIHelpers.screenWidth(context) * 0.25,
                  type: PlutoColumnType.text(),
                  enableFilterMenuItem: false,
                  enableHideColumnMenuItem: false,
                  textAlign: PlutoColumnTextAlign.start,
                  titlePadding: const EdgeInsets.all(8),
                  backgroundColor: SupportBotColors.blueSecondary.shade100,
                  enableContextMenu: false,
                  enableDropToResize: false,
                  enableEditingMode: false,
                  enableColumnDrag: false,
                  readOnly: true,
                  renderer: (PlutoColumnRendererContext rendererContext) {
                    final value = rendererContext.cell.value ?? "N/A";
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: CustomToolTip(
                        message: value.toString(),
                        width: 400,
                        toolTipDirection: CustomToolTip.toolTipRight,
                        isMobile: false,
                        child: Text(
                          value.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  title: S.of(context).classification,
                  field: 'answeredStatus',
                  width: UIHelpers.screenWidth(context) * 0.1,
                  type: PlutoColumnType.text(),
                  enableFilterMenuItem: false,
                  enableHideColumnMenuItem: false,
                  textAlign: PlutoColumnTextAlign.start,
                  titlePadding: const EdgeInsets.all(8),
                  backgroundColor: SupportBotColors.blueSecondary.shade100,
                  enableContextMenu: false,
                  enableDropToResize: false,
                  enableEditingMode: false,
                  enableColumnDrag: false,
                  readOnly: true,
                ),
                PlutoColumn(
                  title: S.of(context).aiQueryAnswer,
                  field: 'aiQueryAnswer',
                  width: UIHelpers.screenWidth(context) * 0.25,
                  type: PlutoColumnType.text(),
                  enableFilterMenuItem: false,
                  enableHideColumnMenuItem: false,
                  textAlign: PlutoColumnTextAlign.start,
                  titlePadding: const EdgeInsets.all(8),
                  backgroundColor: SupportBotColors.blueSecondary.shade100,
                  enableContextMenu: false,
                  enableDropToResize: false,
                  enableEditingMode: false,
                  enableColumnDrag: false,
                  readOnly: true,
                  renderer: (PlutoColumnRendererContext rendererContext) {
                    final value = rendererContext.cell.value ?? "N/A";
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: CustomToolTip(
                        message: value.toString(),
                        width: 400,
                        toolTipDirection: CustomToolTip.toolTipRight,
                        isMobile: false,
                        child: Text(
                          value.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  title: S.of(context).actions,
                  field: 'actions',
                  type: PlutoColumnType.text(),
                  width: UIHelpers.screenWidth(context) * 0.07,
                  enableFilterMenuItem: false,
                  enableHideColumnMenuItem: false,
                  textAlign: PlutoColumnTextAlign.center,
                  titlePadding: const EdgeInsets.all(8),
                  backgroundColor: SupportBotColors.blueSecondary.shade100,
                  enableContextMenu: false,
                  enableDropToResize: false,
                  enableEditingMode: false,
                  enableColumnDrag: false,
                  readOnly: true,
                  renderer: (rendererContext) {
                    return actionsRenderer(rendererContext,
                        selectedDate: selectedDate,
                        selectedMonth: selectedMonth,
                        pipeline: pipeline);
                  },
                ),
              ],
              rows: aiQuerytableData.items.map((item) {
                return PlutoRow(
                  cells: {
                    'id': PlutoCell(value: {
                      'id': item.id ?? "N/A",
                      'isAnswerEdited':
                          item.isAnswerEdited == true ? "Edited" : "Not Edited",
                    }),
                    'ticketDescription':
                        PlutoCell(value: item.ticketDescription ?? "N/A"),
                    'answeredStatus': PlutoCell(
                        value: item.answeredStatus == true
                            ? "Answered"
                            : "Not Answered"),
                    'aiQueryAnswer': PlutoCell(value: item.aIResponse ?? "N/A"),
                    'actions': PlutoCell(value: 'View'),
                  },
                );
              }).toList(),
              configuration: PlutoGridConfiguration(
                style: PlutoGridStyleConfig(
                  enableColumnBorderHorizontal: false,
                  enableColumnBorderVertical: true,
                  enableCellBorderVertical: true,
                  enableCellBorderHorizontal: true,
                  gridBorderRadius: BorderRadius.circular(8),
                  gridPopupBorderRadius: BorderRadius.circular(8),
                  rowHeight: 50,
                  columnHeight: 50,
                  gridBorderColor: Colors.transparent,
                  columnTextStyle: SupportBotTextstyle.columnHeading,
                  cellTextStyle: SupportBotTextstyle.cellHeading,
                  enableGridBorderShadow: true,
                ),
                columnSize: const PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.scale,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                const Text(
                  "Items per page:   ",
                  style: TextStyle(
                      color: SupportBotColors.black,
                      fontWeight: FontWeight.w500),
                ),
                ValueListenableBuilder<int>(
                  valueListenable: pageSize,
                  builder: (context, value, child) {
                    return CustomPaginationDropdown(
                      selectedValue: value,
                      items: const [10, 25, 50, 100, 500, 1000],
                      onChanged: (value) {
                        if (value != null) {
                          pageSize.value = value;
                          currentPage.value = 1;

                          BlocProvider.of<AiQueryAnswerBloc>(context).add(
                            FetchAiQueryAnswerEvent(
                                selectedDate: selectedDate,
                                selectedMonth: selectedMonth,
                                selectedPipeline: pipelineId,
                                page: currentPage.value,
                                pageSize: pageSize.value,
                                selectedClassification: isAnswer),
                          );
                        }
                      },
                      width: 80,
                      height: 40,
                    );
                  },
                ),
              ],
            ),
            UIHelpers.horizontalSpaceRegular,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${(currentPage.value - 1) * pageSize.value + 1} - "
                  "${(currentPage.value * pageSize.value > (aiQuerytableData.totalRecords ?? 0)) ? aiQuerytableData.totalRecords ?? 0 : currentPage.value * pageSize.value} of "
                  "${aiQuerytableData.totalRecords ?? 0}",
                  style: TextStyle(
                    color: SupportBotColors.bluePrimary.shade500,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: currentPage.value > 1
                      ? () {
                          currentPage.value--;

                          BlocProvider.of<AiQueryAnswerBloc>(context).add(
                            FetchAiQueryAnswerEvent(
                                selectedDate: selectedDate,
                                selectedMonth: selectedMonth,
                                selectedPipeline: pipelineId,
                                page: currentPage.value,
                                pageSize: pageSize.value,
                                selectedClassification: isAnswer),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.arrow_back_ios_new, size: 15),
                ),
                ValueListenableBuilder<int>(
                  valueListenable: currentPage,
                  builder: (context, page, _) {
                    return Text(
                      'Page $page',
                      style: const TextStyle(
                          color: SupportBotColors.black,
                          fontWeight: FontWeight.w500),
                    );
                  },
                ),
                IconButton(
                  onPressed: (currentPage.value * pageSize.value) <
                          (aiQuerytableData.totalRecords ?? 0)
                      ? () {
                          currentPage.value++;

                          BlocProvider.of<AiQueryAnswerBloc>(context).add(
                            FetchAiQueryAnswerEvent(
                                selectedDate: selectedDate,
                                selectedMonth: selectedMonth,
                                selectedPipeline: pipelineId,
                                page: currentPage.value,
                                pageSize: pageSize.value,
                                selectedClassification: isAnswer),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.arrow_forward_ios, size: 15),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

Widget actionsRenderer(PlutoColumnRendererContext rendererContext,
    {required DateTime? selectedDate,
    required DateTime? selectedMonth,
    required String? pipeline}) {
  final rows = rendererContext.stateManager.refRows.toList();
  final currentIndex = rows.indexOf(rendererContext.row);
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Align(
        child: PopupMenuTheme(
          data: const PopupMenuThemeData(
            color: SupportBotColors.white,
          ),
          child: PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            offset: const Offset(-40, 0),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: S.of(context).view,
                child: InkWell(
                  onTap: () {
                    _showDetails(context, rows, currentIndex, selectedDate,
                        selectedMonth, pipeline);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.visibility),
                      UIHelpers.horizontalSpaceTiny,
                      Text(S.of(context).view),
                    ],
                  ),
                ),
              ),
              PopupMenuItem<String>(
                value: S.of(context).validatEmail,
                child: InkWell(
                  onTap: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => SendEmailDialog(
                    //     rows: rows,
                    //     currentIndex: currentIndex,
                    //   ),
                    // );
                    _showSendEmailPopup(context, rows, currentIndex,
                        selectedDate, selectedMonth, pipeline);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.loop_rounded),
                      UIHelpers.horizontalSpaceTiny,
                      Text(S.of(context).validatEmail),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

void _showSendEmailPopup(
    BuildContext context,
    List<PlutoRow> rows,
    int currentIndex,
    DateTime? selectedDate,
    DateTime? selectedMonth,
    String? pipeline) async {
  final row = rows[currentIndex];
  final idMap = row.cells['id']?.value;
  final id = idMap != null && idMap is Map<String, dynamic>
      ? idMap['id']?.toString() ?? 'N/A'
      : 'N/A';

  final aiQueryAnswer = row.cells['aiQueryAnswer']?.value ?? "";
  await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(S.of(context).sendEmail),
          content: Text(S.of(context).ValidateEmail),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: SupportBotColors.bluePrimary,
                foregroundColor: SupportBotColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: SupportBotColors.bluePrimary,
                foregroundColor: SupportBotColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              ),
              onPressed: () {
                BlocProvider.of<AiQueryAnswerBloc>(context).add(
                  SendEmailAiAnswerInitialEvent(
                    ticketId: id,
                    agentAnsvalidation: true,
                    selectedPipeline: pipeline,
                    selectedDate: selectedDate,
                    selectedMonth: selectedMonth,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
          ],
        );
      });
}

void _showDetails(BuildContext context, List<PlutoRow> rows, int currentIndex,
    DateTime? selectedDate, DateTime? selectedMonth, String? pipeline) async {
  bool isNextEnabled = currentIndex < rows.length - 1;
  bool isPreviousEnabled = currentIndex > 0;
  final row = rows[currentIndex];
  final idMap = row.cells['id']?.value;
  final id = idMap != null && idMap is Map<String, dynamic>
      ? idMap['id']?.toString() ?? 'N/A'
      : 'N/A';
  final isAnswerEdited = idMap != null && idMap is Map<String, dynamic>
      ? idMap['isAnswerEdited']?.toString() ?? 'Not Edited'
      : 'Not Edited';
  final description = row.cells['ticketDescription']?.value ?? "";
  final answeredStatus = row.cells['answeredStatus']?.value ?? "";
  final aiQueryAnswer = row.cells['aiQueryAnswer']?.value ?? "";
  final isEmailSend = idMap != null &&
          idMap is Map<String, dynamic> &&
          idMap['agentAnsValidation'] == true
      ? 'Send'
      : 'Not Send';
  // final link = row.cells['link']?.value ?? "";

  final result = await showDialog<Map<String, String>>(
    context: context,
    builder: (BuildContext dialogContext) {
      final aiQueryAnswerController =
          TextEditingController(text: aiQueryAnswer);
      bool isEditing = false;
      return StatefulBuilder(
        builder: (BuildContext statefulContext, StateSetter setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 14,
                  ),
                  onPressed: isPreviousEnabled
                      ? () {
                          Navigator.pop(dialogContext);
                          if (isPreviousEnabled) {
                            _showDetails(context, rows, currentIndex - 1,
                                selectedDate, selectedMonth, pipeline);
                          }
                        }
                      : null,
                  color: isPreviousEnabled ? Colors.black : Colors.grey,
                ),
                Center(
                  child: Text(
                    'Ticket Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: SupportBotColors.bluePrimary.shade500,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: isNextEnabled
                        ? () {
                            Navigator.pop(dialogContext);
                            if (isNextEnabled) {
                              _showDetails(context, rows, currentIndex + 1,
                                  selectedDate, selectedMonth, pipeline);
                            }
                          }
                        : null,
                    color: isNextEnabled ? Colors.black : Colors.grey,
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ))
              ],
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(),
                    _buildDetailRow('Ticket Id :', id),
                    _buildDetailRow('Ticket Description :', description),
                    _buildDetailRow('Answer Status :', answeredStatus),
                    if (isEditing)
                      _buildEditableRow(
                          'AI Query Answer :', aiQueryAnswerController)
                    else
                      _buildDetailRow('AI Query Answer :', aiQueryAnswer),
                    _buildDetailRow('Email Status :', isEmailSend),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    icon: Icon(Icons.cancel,
                        color: SupportBotColors.bluePrimary.shade500),
                    label: Text(
                      'Cancel',
                      style: TextStyle(
                          color: SupportBotColors.bluePrimary.shade500),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: SupportBotColors.bluePrimary.shade500),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (isEditing) {
                        BlocProvider.of<AiQueryAnswerBloc>(context).add(
                          UpdateAiAnswerInitialEvent(
                            ticketId: id,
                            newAnswer: aiQueryAnswerController.text,
                            selectedPipeline: pipeline,
                            selectedDate: selectedDate,
                            selectedMonth: selectedMonth,
                          ),
                        );
                        Navigator.of(dialogContext).pop({
                          'aiQueryAnswer': aiQueryAnswerController.text,
                        });
                      } else {
                        setState(() {
                          isEditing = true;
                        });
                      }
                    },
                    icon: Icon(
                      isEditing ? Icons.save : Icons.edit,
                      color: Colors.white,
                    ),
                    label: Text(
                      isEditing ? 'Save' : 'Edit',
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SupportBotColors.bluePrimary.shade500,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 40),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );

  if (result != null) {
    print('Updated AI Query Answer: ${result['aiQueryAnswer']}');
  }
}

Widget _buildDetailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 8),
        SelectableText(
          value,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ],
    ),
  );
}

Widget _buildEditableRow(String title, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          maxLines: 7,
        ),
      ],
    ),
  );
}

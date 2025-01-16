import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/bloc/add_answer_validation/add_answer_validation_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/bloc/ai_query_bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/bloc/update_ai_answer_bloc.dart';
import 'package:support_bot_dashboard/utils/applications_pluto_helper_methods.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
import 'package:support_bot_dashboard/utils/service/instance_sharing_service.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class Renderers {
  static TextStyle frozenStyle(
      PlutoColumnRendererContext rendererContext, TextStyle textStyle) {
    if (rendererContext.cell.column.frozen == PlutoColumnFrozen.start ||
        rendererContext.cell.column.frozen == PlutoColumnFrozen.end) {}
    return textStyle;
  }

  static Widget textRenderer(
    PlutoColumnRendererContext rendererContext, {
    TextStyle? textStyle,
  }) {
    final String text = rendererContext.cell.value ?? "";
    textStyle ??= frozenStyle(
        rendererContext,
        SupportBotTextstyle.small
            .copyWith(fontSize: 14, color: SupportBotColors.gray.shade800));

    return Text(
      text,
      textAlign: TextAlign.start,
      style: textStyle,
      overflow: TextOverflow.ellipsis,
    );
  }

  static Widget scoreTextRenderer(
    PlutoColumnRendererContext rendererContext, {
    TextStyle? textStyle,
  }) {
    final num value = rendererContext.cell.value ?? "";
    textStyle ??= frozenStyle(
        rendererContext,
        SupportBotTextstyle.small.copyWith(
            fontSize: 14,
            color:
                value > 5 ? const Color(0xFF11972C) : const Color(0xFFFD0101)));

    return Text(
      "$value/10",
      style: textStyle,
    );
  }

  static Widget applicationTextStatusRenderer(
    PlutoColumnRendererContext rendererContext, {
    TextStyle? textStyle,
  }) {
    final dynamic status = rendererContext.cell.value;
    final String displayText = (status == true)
        ? "Validate"
        : (status == false)
            ? "Not Validate"
            : "N/A";

    textStyle ??= frozenStyle(
        rendererContext,
        SupportBotTextstyle.small.copyWith(
          fontSize: 14,
          color: ApplicationsPlutoHelperMethods.getTextColorFromStatus(
            status: displayText,
          ),
        ));

    return Text(
      displayText,
      style: textStyle,
    );
  }

  static Widget actionButtonRenderer(
    PlutoColumnRendererContext rendererContext, {
    required BuildContext context,
    void Function(String?)? onDelete,
  }) {
    final actionData =
        rendererContext.row.cells["Action"]?.value as Map<String, dynamic>? ??
            {};
    return Align(
      alignment: Alignment.topLeft,
      child: PopupMenuTheme(
          data: const PopupMenuThemeData(
            color: SupportBotColors.white,
          ),
          child: PopupMenuButton<String>(
            tooltip: "",
            icon: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: const Icon(
                Icons.more_vert_rounded,
              ),
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: "view",
                onTap: () {
                  showTicketDetailsDialog(context,
                      rowData: rendererContext.row);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.visibility,
                    ),
                    UIHelpers.horizontalSpaceTiny,
                    Text(
                      'View',
                      style: SupportBotTextstyle.small.copyWith(
                          color: SupportBotColors.gray.shade800,
                          // fontFamily: FontFamily.poppinsRegular,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: "validate",
                onTap: () {
                  showValidateAnswerDialog(context, rendererContext.row);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.loop_rounded,
                      //size: 14,
                    ),
                    UIHelpers.horizontalSpaceTiny,
                    Text("Validate",
                        style: SupportBotTextstyle.small.copyWith(
                            color: SupportBotColors.gray.shade800,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              )
            ],
          )),
    );
  }

  static void showValidateAnswerDialog(BuildContext context, PlutoRow rowData) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            title: const Text(
              'Validate AI Answer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'Do you want to Validate AI Answer for this ticket?',
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: SupportBotColors.bluePrimary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(color: SupportBotColors.bluePrimary),
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text(
                  'No',
                  style: TextStyle(color: SupportBotColors.white),
                ),
              ),
              BlocProvider(
                create: (context) => AddAnswerValidationBloc(),
                child: BlocConsumer<AddAnswerValidationBloc,
                    AddAnswerValidationState>(
                  listener: (context, state) {
                    if (state is AddAnswerValidationSuccessState) {
                      serviceLocator<InstanceSharingService>()
                          .aiQueryBloc
                          ?.add(AIQueryInitialEvent(
                            classificationFilterValue:
                                serviceLocator<InstanceSharingService>()
                                    .classificationFilterValue,
                            selectedPipelineValueList:
                                serviceLocator<InstanceSharingService>()
                                    .selectedPipelineValueList,
                          ));
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SupportBotColors.bluePrimary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: SupportBotColors.bluePrimary),
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onPressed: () {
                        BlocProvider.of<AddAnswerValidationBloc>(context).add(
                            AddAnswerValidationInitialEvent(
                                agentAnsValidation:
                                    rowData.cells['validation_status']?.value ==
                                        "Validated",
                                ticketId: rowData.cells['id']?.value ?? "",
                                pipeline:
                                    serviceLocator<InstanceSharingService>()
                                            .selectedPipelineValueList
                                            ?.firstOrNull ??
                                        "11257490"));
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: SupportBotColors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }

  static Widget tooltip(
    PlutoColumnRendererContext rendererContext, {
    TextStyle? textStyle,
  }) {
    final cellValue = rendererContext.cell.value;

    return SingleChildScrollView(
      child: MouseRegion(
        onEnter: (_) {},
        child: SizedBox(
          width: 20,
          child: SingleChildScrollView(
            child: CustomToolTip(
              width: 300,
              isMobile: false,
              message: cellValue.toString(),
              child: Container(
                width: 2,
                height: 50,
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                alignment: Alignment.centerLeft,
                child: Text(
                  cellValue.toString(),
                  style: const TextStyle(
                    color: SupportBotColors.disablePrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget validationDropDown(
    PlutoColumnRendererContext rendererContext, {
    TextStyle? textStyle,
  }) {
    final cellValue = rendererContext.cell.value;

    return SingleChildScrollView(
      child: MouseRegion(
        onEnter: (_) {},
        child: SizedBox(
          width: 20,
          child: SingleChildScrollView(
            child: Tooltip(
              height: 2,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8.0),
              ),
              message: cellValue.toString(),
              verticalOffset: 2,
              preferBelow: false,
              child: Container(
                width: 2,
                height: 50,
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                alignment: Alignment.centerLeft,
                child: Text(
                  cellValue.toString(),
                  style: const TextStyle(
                    color: SupportBotColors.disablePrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void showTicketDetailsDialog(
    BuildContext context, {
    required PlutoRow rowData,
  }) {
    TextEditingController aiQueryController = TextEditingController(
        text:
            rowData.cells['ai_query_answer']?.value ?? "Answer not generated");
    bool isEditing = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Ticket Details",
                          style: SupportBotTextstyle.columnHeading
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      UIHelpers.verticalSpaceSmall,
                      const Divider(),
                      UIHelpers.verticalSpaceSmall,
                      Text(
                        "Ticket ID: ",
                        style: SupportBotTextstyle.columnHeading,
                      ),
                      UIHelpers.verticalSpaceTiny,
                      Text(rowData.cells['id']?.value ?? '',
                          style: SupportBotTextstyle.cellHeading),
                      UIHelpers.verticalSpaceRegular,
                      Text(
                        "Ticket Description: ",
                        style: SupportBotTextstyle.columnHeading,
                      ),
                      UIHelpers.verticalSpaceTiny,
                      Text(
                        rowData.cells['ticket_description']?.value ?? '',
                        style: SupportBotTextstyle.cellHeading,
                      ),
                      UIHelpers.verticalSpaceMedium,
                      Text(
                        "Answer Status: ",
                        style: SupportBotTextstyle.columnHeading,
                      ),
                      UIHelpers.verticalSpaceTiny,
                      Text(
                        rowData.cells['classification']?.value ?? '',
                        style: SupportBotTextstyle.cellHeading,
                      ),
                      UIHelpers.verticalSpaceRegular,
                      Text(
                        "AI query answer: ",
                        style: SupportBotTextstyle.columnHeading,
                      ),
                      TextField(
                        controller: aiQueryController,
                        enabled: isEditing,
                        style: isEditing
                            ? SupportBotTextstyle.cellHeading.copyWith(
                                color: SupportBotColors.black,
                                fontWeight: FontWeight.w500,
                              )
                            : SupportBotTextstyle.cellHeading.copyWith(
                                color: SupportBotColors.black,
                              ),
                        decoration: const InputDecoration(
                            hintStyle: SupportBotTextstyle.cellHeading,
                            disabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            labelStyle: SupportBotTextstyle.cellHeading),
                      ),
                      Text(
                        "AI Answer Validation Status: ",
                        style: SupportBotTextstyle.columnHeading,
                      ),
                      Text(
                        rowData.cells['validation_status']?.value ??
                            "Not Validated",
                        style: SupportBotTextstyle.cellHeading,
                      ),
                      UIHelpers.verticalSpaceRegular,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 40,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.cancel,
                                color: SupportBotColors.bluePrimary),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: SupportBotColors.bluePrimary),
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            label: const Text(
                              "Cancel",
                              style: TextStyle(
                                  color: SupportBotColors.bluePrimary),
                            ),
                          ),
                          BlocProvider(
                            create: (context) => UpdateAiAnswerBloc(),
                            child: BlocConsumer<UpdateAiAnswerBloc,
                                UpdateAiAnswerState>(
                              listener: (context, state) {
                                if (state is UpdateAiAnswerSuccessState) {
                                  serviceLocator<InstanceSharingService>()
                                      .aiQueryBloc
                                      ?.add(AIQueryInitialEvent(
                                        classificationFilterValue:
                                            serviceLocator<
                                                    InstanceSharingService>()
                                                .classificationFilterValue,
                                        selectedPipelineValueList:
                                            serviceLocator<
                                                    InstanceSharingService>()
                                                .selectedPipelineValueList,
                                      ));
                                  Navigator.pop(context);
                                }
                              },
                              builder: (context, state) {
                                if (state is UpdateAiAnswerSuccessState) {
                                  return ElevatedButton.icon(
                                    icon: Icon(
                                      isEditing ? Icons.save : Icons.edit,
                                      color: SupportBotColors.white,
                                    ),
                                    onPressed: () {
                                      if (isEditing) {
                                        context.read<UpdateAiAnswerBloc>().add(
                                              UpdateAiAnswerInitialEvent(
                                                ticketId: rowData
                                                        .cells['id']?.value ??
                                                    '',
                                                updatedAnswer:
                                                    aiQueryController.text,
                                                selectedPipelineValue:
                                                    serviceLocator<
                                                            InstanceSharingService>()
                                                        .selectedPipelineValue,
                                              ),
                                            );
                                      }
                                      setState(() {
                                        isEditing = !isEditing;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      backgroundColor:
                                          SupportBotColors.bluePrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    label: Text(
                                      isEditing ? "Save" : "Edit",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                }

                                return ElevatedButton.icon(
                                  icon: Icon(
                                    isEditing ? Icons.save : Icons.edit,
                                    color: SupportBotColors.white,
                                  ),
                                  onPressed: () {
                                    if (isEditing) {
                                      BlocProvider.of<UpdateAiAnswerBloc>(
                                              context)
                                          .add(
                                        UpdateAiAnswerInitialEvent(
                                          ticketId:
                                              rowData.cells['id']?.value ?? '',
                                          updatedAnswer: aiQueryController.text,
                                        ),
                                      );
                                    }
                                    setState(() {
                                      isEditing = !isEditing;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                    backgroundColor:
                                        SupportBotColors.bluePrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  label: Text(
                                    isEditing ? "Save" : "Edit",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

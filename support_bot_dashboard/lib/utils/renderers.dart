import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/bloc/add_answer_validation/add_answer_validation_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/bloc/ai_query_bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/bloc/update_ai_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/get_validation_detailsentitie_entite_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/get_validation_details_bloc/get_validation_details_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_action_bloc/ticket_classification_action_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
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
        ? "correct"
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

  static Widget ticketClassificationActionRenderer(
    PlutoColumnRendererContext rendererContext, {
    required BuildContext context,
    void Function(String?)? onDelete,
  }) {
    final rowData =
        rendererContext.row.cells.map((key, cell) => MapEntry(key, cell.value));

    return BlocConsumer<TicketClassificationTabBloc, TicketClassificationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Align(
          alignment: Alignment.topLeft,
          child: PopupMenuTheme(
            data: const PopupMenuThemeData(
              color: Colors.white,
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
                  value: "View",
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Ticket Details"),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: rowData.entries.map((entry) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${entry.key}: ",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: "${entry.value}",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Close",
                                style: TextStyle(
                                    color: SupportBotColors.bluePrimary),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  },
                  child: BlocProvider(
                    create: (context) => TicketClassificationActionBloc(),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 14,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "View",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: "Update",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Update Ticket"),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Do you Want to Mark This Ticket as a Contact ${rowData['classification'] ?? 'N/A'} in HubSpot", // Display the ticket ID
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: SupportBotColors.bluePrimary,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14.0, horizontal: 24.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              child: const Text(
                                "No",
                                style: TextStyle(
                                  color: SupportBotColors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  TicketClassificationActionBloc(),
                              child: BlocBuilder<TicketClassificationActionBloc,
                                  TicketClassificationActionState>(
                                builder: (context, state) {
                                  if (state
                                      is TicketClassificationActionLoadingState) {
                                    return const CircularProgressIndicator();
                                  }
                                  if (state
                                      is TicketClassificationActionSucssesState) {
                                    return TextButton(
                                      onPressed: () {
                                        final classification =
                                            rowData['classification'] ?? '';

                                        final ticketId = rowData['id'] ?? '';

                                        context
                                            .read<
                                                TicketClassificationActionBloc>()
                                            .add(
                                              TicketClassificationActionOnEvent(
                                                classification: classification,
                                                ticketId: ticketId,
                                              ),
                                            );

                                        Navigator.of(context).pop();
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            SupportBotColors.bluePrimary,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14.0, horizontal: 24.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(
                                          color: SupportBotColors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }
                                  return TextButton(
                                    onPressed: () {
                                      final classification =
                                          rowData['classification'] ?? '';

                                      final ticketId = rowData['id'] ?? '';

                                      context
                                          .read<
                                              TicketClassificationActionBloc>()
                                          .add(
                                            TicketClassificationActionOnEvent(
                                              classification: classification,
                                              ticketId: ticketId,
                                            ),
                                          );
                                      BlocProvider(
                                        create: (context) =>
                                            TicketClassificationTabBloc()
                                              ..add(
                                                  TicketClassificationDataCallEvent()),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          SupportBotColors.bluePrimary,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14.0, horizontal: 24.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(
                                        color: SupportBotColors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.update,
                        size: 14,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
    final GetValidationDetailsEntiterModel? getValidationDetailsEntiterModel;
    final rowData =
        rendererContext.row.cells.map((key, cell) => MapEntry(key, cell.value));

    final bool isDisabled = rendererContext.cell.value == true;
    String? selectedValue =
        rendererContext.cell.value == true ? 'Validate' : null;

    final List<String> items = ['correct', 'incorrect'];

    return Center(
      child: BlocProvider(
        create: (context) => GetValidationDetailsBloc(),
        child: BlocBuilder<GetValidationDetailsBloc, GetValidationDetailsState>(
          builder: (context, state) {
            return DropdownButton<String>(
                onTap: () {
                  BlocProvider.of<GetValidationDetailsBloc>(context).add(
                      GetValidationDetailsvalidateEvent(id: rowData['id']));
                },
                dropdownColor: SupportBotColors.white,
                underline: Container(color: Colors.transparent),
                value: selectedValue,
                hint: Text(selectedValue ?? 'Select an option'),
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) async {
                  if (state is GetValidationDetailsSucssesState &&
                      state.getValidationDetailsEntiterModel?.data?.status ==
                          false) {
                    Navigator.pop(context);
                    return;
                  }

                  selectedValue = newValue;

                  rendererContext.stateManager.changeCellValue(
                    rendererContext.cell,
                    newValue == 'Validate',
                  );
                }

                // isDisabled
                //     ? null
                //     : (String? newValue) {
                //         selectedValue = newValue;

                //         rendererContext.stateManager.changeCellValue(
                //           rendererContext.cell,
                //           newValue == 'Validate',
                //         );
                //       },
                );
          },
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

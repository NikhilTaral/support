import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/domain/entities/ai_query_answer_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/bloc/add_answer_validation/add_answer_validation_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/bloc/ai_query_bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/bloc/update_ai_answer_bloc.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/custom_snackbar.dart';
import 'package:support_bot_dashboard/utils/service/instance_sharing_service.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class ValidateAnswerDialog extends StatelessWidget {
  final PlutoRow rowData;

  const ValidateAnswerDialog({required this.rowData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final idMap = rowData.cells['id']?.value;
    final id = idMap != null && idMap is Map<String, dynamic>
        ? idMap['id']?.toString() ?? 'N/A'
        : 'N/A';
    final validationStatus =
        rowData.cells['validation_status']?.value == "Validated";

    final s = serviceLocator<S>();

    return AlertDialog(
      backgroundColor: SupportBotColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      title: Text(
        s.ValidateAIAnswerText,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(
        s.ValidateAIAnsweTicketrText,
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: SupportBotColors.bluePrimary,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: SupportBotColors.bluePrimary),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text(
            s.NoText,
            style: SupportBotTextstyle.mediumHint.copyWith(
              color: SupportBotColors.white,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AddAnswerValidationBloc(),
          child:
              BlocConsumer<AddAnswerValidationBloc, AddAnswerValidationState>(
            listener: (context, state) {
              if (state is AddAnswerValidationSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackbar(
                    message: s.aiAnswerValidationSuccessfullyText,
                    context: context,
                    isSuccess: true,
                  ),
                );
                serviceLocator<InstanceSharingService>()
                    .aiQueryBloc
                    ?.add(AIQueryInitialEvent(
                      classificationFilterValue:
                          serviceLocator<InstanceSharingService>()
                              .classificationFilterValue,
                      selectedPipelineValueList:
                          serviceLocator<InstanceSharingService>()
                                  .selectedPipelineValueList ??
                              "11257490",
                      startDate:
                          serviceLocator<InstanceSharingService>().startDate,
                      endDate: serviceLocator<InstanceSharingService>().endDate,
                    ));
                Navigator.pop(context);
              } else if (state is AddAnswerValidationFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackbar(
                    message: s.aiAnswerValidationFailureText,
                    context: context,
                    isSuccess: false,
                  ),
                );
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SupportBotColors.bluePrimary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: SupportBotColors.bluePrimary),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  BlocProvider.of<AddAnswerValidationBloc>(context).add(
                    AddAnswerValidationInitialEvent(
                      agentAnsValidation: validationStatus,
                      ticketId: id.toString(),
                      pipeline: serviceLocator<InstanceSharingService>()
                              .selectedPipelineValueList ??
                          "11257490",
                    ),
                  );
                },
                child: Text(
                  s.yesText,
                  style: SupportBotTextstyle.mediumHint.copyWith(
                    color: SupportBotColors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TicketDetailsDialog extends StatelessWidget {
  final PlutoRow rowData;
  final List<AiQueryAttributeItem> allRows;
  final int initialIndex;

  TicketDetailsDialog({
    required this.rowData,
    required this.allRows,
    required this.initialIndex,
    Key? key,
  }) : super(key: key);
  final s = serviceLocator<S>();
  @override
  Widget build(BuildContext context) {
    TextEditingController aiQueryController = TextEditingController(
      text: rowData.cells['ai_query_answer']?.value ?? "Answer not generated",
    );
    bool isEditing = false;

    int currentIndex = initialIndex;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        final rowData = allRows[currentIndex];
        final id = rowData.id?.toString() ?? '';
        final ticketDescription = rowData.ticketDescription?.toString() ?? '';
        final answeredStatus =
            rowData.answeredStatus == "true" ? "Answered" : "Not Answered";
        final validationStatus =
            rowData.agentAnsValidation == true ? "Validated" : "Not Validated";
        final answerEditedStatus =
            rowData.isAnswerEdited == true ? "Edited" : "Not Edited";

        return Dialog(
          backgroundColor: SupportBotColors.white,
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (currentIndex > 0) {
                              setState(() {
                                currentIndex--;
                              });
                            }
                          },
                          icon: const Icon(Icons.arrow_circle_left_outlined),
                        ),
                        Text(
                          s.TicketDetailsText,
                          style: SupportBotTextstyle.columnHeading
                              .copyWith(fontSize: 20),
                        ),
                        IconButton(
                          onPressed: () {
                            if (currentIndex < allRows.length - 1) {
                              setState(() {
                                currentIndex++;
                              });
                            }
                          },
                          icon: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ],
                    ),
                  ),
                  UIHelpers.verticalSpaceSmall,
                  const Divider(),
                  UIHelpers.verticalSpaceSmall,
                  Text(
                    s.TicketIDText,
                    style: SupportBotTextstyle.columnHeading,
                  ),
                  UIHelpers.verticalSpaceTiny,
                  Text(id, style: SupportBotTextstyle.cellHeading),
                  UIHelpers.verticalSpaceRegular,
                  Text(
                    s.TicketDescriptionText,
                    style: SupportBotTextstyle.columnHeading,
                  ),
                  UIHelpers.verticalSpaceTiny,
                  Text(ticketDescription,
                      style: SupportBotTextstyle.cellHeading),
                  UIHelpers.verticalSpaceMedium,
                  Text(
                    s.AnswerStatusText,
                    style: SupportBotTextstyle.columnHeading,
                  ),
                  UIHelpers.verticalSpaceTiny,
                  Text(answeredStatus, style: SupportBotTextstyle.cellHeading),
                  UIHelpers.verticalSpaceRegular,
                  Text(
                    s.ValidationStatusText,
                    style: SupportBotTextstyle.columnHeading,
                  ),
                  UIHelpers.verticalSpaceTiny,
                  Text(validationStatus,
                      style: SupportBotTextstyle.cellHeading),
                  UIHelpers.verticalSpaceRegular,
                  Text(
                    s.AnswerEditedStatusText,
                    style: SupportBotTextstyle.columnHeading,
                  ),
                  UIHelpers.verticalSpaceTiny,
                  Text(answerEditedStatus,
                      style: SupportBotTextstyle.cellHeading),
                  UIHelpers.verticalSpaceRegular,
                  Text(
                    s.AIQueryAnswerText,
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
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      labelStyle: SupportBotTextstyle.cellHeading,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                  ),
                  UIHelpers.verticalSpaceRegular,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        label: Text(
                          s.cancel,
                          style: SupportBotTextstyle.hint
                              .copyWith(color: SupportBotColors.bluePrimary),
                        ),
                      ),
                      UIHelpers.horizontalSpaceRegular,
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
                                        serviceLocator<InstanceSharingService>()
                                            .classificationFilterValue,
                                    selectedPipelineValueList:
                                        serviceLocator<InstanceSharingService>()
                                            .selectedPipelineValueList,
                                    startDate:
                                        serviceLocator<InstanceSharingService>()
                                            .startDate,
                                    endDate:
                                        serviceLocator<InstanceSharingService>()
                                            .endDate,
                                  ));
                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton.icon(
                              icon: Icon(
                                isEditing ? Icons.save : Icons.edit,
                                color: SupportBotColors.white,
                              ),
                              onPressed: () {
                                if (isEditing) {
                                  context.read<UpdateAiAnswerBloc>().add(
                                        UpdateAiAnswerInitialEvent(
                                          ticketId: id,
                                          updatedAnswer: aiQueryController.text,
                                          selectedPipelineValue: serviceLocator<
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
                                backgroundColor: SupportBotColors.bluePrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              label: Text(
                                isEditing ? s.save : s.editText,
                                style: SupportBotTextstyle.hint
                                    .copyWith(color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

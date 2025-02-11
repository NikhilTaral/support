import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/domain/entities/ai_query_answer_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/bloc/add_answer_validation/add_answer_validation_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/bloc/ai_query_bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/bloc/update_ai_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart'
    as ticketClassificationBloc;
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/get_validation_details_bloc/get_validation_details_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/update_classification_validation_bloc/update_classification_validation_bloc.dart';
import 'package:support_bot_dashboard/utils/ai_quiery_action_view.dart';
import 'package:support_bot_dashboard/utils/applications_pluto_helper_methods.dart';
import 'package:support_bot_dashboard/utils/ticket_classification_renderer.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
import 'package:support_bot_dashboard/utils/service/instance_sharing_service.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class Renderers {
  static TextStyle frozenStyle(
      PlutoColumnRendererContext rendererContext, TextStyle textStyle) {
    if (rendererContext.cell.column.frozen == PlutoColumnFrozen.start ||
        rendererContext.cell.column.frozen == PlutoColumnFrozen.end) {}
    return textStyle;
  }

  static Widget statusRenderer(PlutoColumnRendererContext context) {
    final bool? value = context.cell.value;

    final String displayText = value == true ? 'Updated' : 'Not Updated';

    return Center(
      child: Text(
        displayText,
      ),
    );
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
      text.isEmpty ? "N/A" : text,
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
    final rowsData = [rowData];
    final actionData =
        rendererContext.row.cells["action"]?.value as Map<String, dynamic>? ??
            {};
    final isUpdatedToHubspot = actionData["isUpdatedToHubspot"] ?? "";
    final id = rowData['id'] ?? '';
    final classification = rowData['classification'] ?? 'N/A';
    int index = rendererContext.cell.value?['index'] ?? 0;
    final allRows = rendererContext.cell.value?['allRows'] ?? [];
    return TicketClassificationActionRenderer(
      classification: classification,
      id: id,
      isUpdatedToHubspot: isUpdatedToHubspot,
      rowsData: rowsData,
      onDelete: onDelete,
      index: index,
      allRows: allRows,
    );
  }

  static Widget actionButtonRenderer(
    PlutoColumnRendererContext rendererContext, {
    required BuildContext context,
    void Function(String?)? onDelete,
  }) {
    int index = rendererContext.cell.value?['index'] ?? 0;
    final allRows = rendererContext.cell.value?['allRows'] ?? [];
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
            child: const Icon(Icons.more_vert_rounded),
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: "view",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return TicketDetailsDialog(
                      rowData: rendererContext.row,
                      allRows: allRows,
                      initialIndex: index,
                    );
                  },
                );
              },
              child: Row(
                children: [
                  const Icon(Icons.visibility),
                  UIHelpers.horizontalSpaceTiny,
                  Text(
                    'View',
                    style: SupportBotTextstyle.small.copyWith(
                      color: SupportBotColors.gray.shade800,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: "validate",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ValidateAnswerDialog(rowData: rendererContext.row);
                  },
                );
              },
              child: Row(
                children: [
                  const Icon(Icons.loop_rounded),
                  UIHelpers.horizontalSpaceTiny,
                  Text(
                    "Validate",
                    style: SupportBotTextstyle.small.copyWith(
                      color: SupportBotColors.gray.shade800,
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
                  style: SupportBotTextstyle.hint.copyWith(
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
    List<String> piplineid = const [],
  }) {
    final rowData =
        rendererContext.row.cells.map((key, cell) => MapEntry(key, cell.value));
    String? selectedValue;
    final id = rowData['id'] ?? "";
    if (rowData['validation'] == "") {
      final List<String> items = ['Correct', 'Incorrect'];
      return Center(
          child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetValidationDetailsBloc(),
          ),
          BlocProvider(
            create: (context) => UpdateClassificationValidationBloc(),
          ),
        ],
        child:
            BlocConsumer<GetValidationDetailsBloc, GetValidationDetailsState>(
          listener: (context, state) {
            if (state is UpdateClassificationValidationSuccessState) {
              serviceLocator<InstanceSharingService>()
                  .ticketClassificationBloc
                  ?.add(ticketClassificationBloc.TickiteClassificationEvent());
            }
          },
          builder: (context, state) {
            return DropdownButton<String>(
              alignment: Alignment.center,
              isDense: true,
              icon: const Icon(
                size: 16,
                Icons.keyboard_arrow_down_rounded,
                color: SupportBotColors.bluePrimary,
              ),
              borderRadius: BorderRadius.circular(2),
              onTap: () {
                BlocProvider.of<GetValidationDetailsBloc>(context)
                    .add(GetValidationDetailsvalidateEvent(id: rowData['id']));
              },
              dropdownColor: SupportBotColors.white,
              underline: Container(color: Colors.transparent),
              value: selectedValue,
              hint: Text(selectedValue ?? 'Select'),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue?.toLowerCase() == "correct") {
                  final rowData = rendererContext.row.cells
                      .map((key, cell) => MapEntry(key, cell.value));
                  bool validationValue = newValue?.toLowerCase() == 'correct';
                  BlocProvider.of<UpdateClassificationValidationBloc>(context)
                      .add(
                    UpdateClassificationValidationstateEvent(
                      id: rowData['id'],
                      pipeline: (piplineid).join(','),
                      validation: newValue?.toLowerCase(),
                    ),
                  );

                  Future.delayed(const Duration(microseconds: 2000000), () {
                    final bloc =
                        BlocProvider.of<TicketClassificationTabBloc>(context);
                    BlocProvider.of<TicketClassificationTabBloc>(context)
                        .add(TicketClassificationDataCallEvent(
                      startDate: bloc.startDate,
                      endDate: bloc.endDate,
                      fieldValue: bloc.selectedPipelineId.split(','),
                      page:
                          BlocProvider.of<TicketClassificationTabBloc>(context)
                              .page,
                      pageSize:
                          BlocProvider.of<TicketClassificationTabBloc>(context)
                              .pageSize,
                    ));
                  });

                  if (state is GetValidationDetailsSuccessState &&
                      state.getValidationDetailsAttributeModel?.data?.status ==
                          false) {
                    Navigator.pop(context);
                    return;
                  }

                  if (newValue == '' || newValue == null) {
                    rendererContext.stateManager.changeCellValue(
                      rendererContext.cell,
                      false,
                    );
                    selectedValue = null;
                  } else {
                    selectedValue = newValue;
                    rendererContext.stateManager.changeCellValue(
                      rendererContext.cell,
                      validationValue,
                    );
                  }
                } else if (newValue?.toLowerCase() == "incorrect") {
                  final rowData = rendererContext.row.cells
                      .map((key, cell) => MapEntry(key, cell.value));
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      String reason = '';
                      String _selectedClassification = 'Select';

                      return AlertDialog(
                        title: Text(serviceLocator<S>().emailValidations),
                        backgroundColor: SupportBotColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        content: SizedBox(
                          width: UIHelpers.screenWidth(context) * 0.3,
                          height: UIHelpers.screenHeight(context) * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                onChanged: (value) {
                                  reason = value;
                                },
                                decoration: InputDecoration(
                                  hintText: S.of(context).comments,
                                  contentPadding: const EdgeInsets.all(16.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                maxLines: 4,
                              ),
                              UIHelpers.verticalSpaceSmall,
                              Text(
                                S.of(context).classification,
                                style: SupportBotTextstyle.subheadingH6
                                    .copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                              ),
                              UIHelpers.verticalSpaceTiny,
                              SizedBox(
                                height: UIHelpers.screenHeight(context) * 0.05,
                                child: DropdownButtonFormField<String>(
                                  value: _selectedClassification,
                                  items: [
                                    'Select',
                                    'Spam/Marketing',
                                    'No Action Required',
                                    'Genuine Query',
                                    'Acknowledgement Required'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style:
                                            SupportBotTextstyle.medium.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: SupportBotColors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newClassification) {
                                    if (newClassification != null) {
                                      _selectedClassification =
                                          newClassification;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(8.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 30,
                                    color: SupportBotColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: SupportBotColors.danger,
                              foregroundColor: SupportBotColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 40),
                            ),
                            child: Text(
                              S.of(context).cancel,
                              style: SupportBotTextstyle.hint.copyWith(
                                color: SupportBotColors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: SupportBotColors.bluePrimary,
                              foregroundColor: SupportBotColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 40),
                            ),
                            child: Text(
                              S.of(context).save,
                              style: SupportBotTextstyle.hint.copyWith(
                                color: SupportBotColors.white,
                              ),
                            ),
                            onPressed: () async {
                              if (reason.isNotEmpty &&
                                  _selectedClassification != 'Select') {
                                BlocProvider.of<
                                            UpdateClassificationValidationBloc>(
                                        context)
                                    .add(
                                  UpdateClassificationValidationstateEvent(
                                    id: id,
                                    pipeline: (piplineid).join(','),
                                    reason: reason,
                                    validatedClassification:
                                        _selectedClassification,
                                    validation: newValue?.toLowerCase(),
                                  ),
                                );
                                Future.delayed(
                                    const Duration(microseconds: 200000), () {
                                  final bloc = BlocProvider.of<
                                      TicketClassificationTabBloc>(context);
                                  BlocProvider.of<TicketClassificationTabBloc>(
                                          context)
                                      .add(
                                    TicketClassificationDataCallEvent(
                                      startDate: bloc.startDate,
                                      endDate: bloc.endDate,
                                      fieldValue:
                                          bloc.selectedPipelineId.split(','),
                                      page: BlocProvider.of<
                                                  TicketClassificationTabBloc>(
                                              context)
                                          .page,
                                      pageSize: BlocProvider.of<
                                                  TicketClassificationTabBloc>(
                                              context)
                                          .pageSize,
                                    ),
                                  );
                                });

                                if (state is GetValidationDetailsSuccessState &&
                                    state.getValidationDetailsAttributeModel
                                            ?.data?.status ==
                                        false) {
                                  Navigator.of(dialogContext).pop();
                                  return;
                                }
                                Navigator.of(dialogContext).pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please provide reason and select classification')),
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              disabledHint: const Text('No selection'),
            );
          },
        ),
      ));
    } else {
      final validation = rowData['vadidation'] ?? "";
      return Center(
        child: Text(rendererContext.cell.value),
      );
    }
  }
}

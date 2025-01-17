import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/bloc/add_answer_validation/add_answer_validation_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/bloc/ai_query_bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/bloc/update_ai_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_pluto_table_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart'
    as ticketClassificationBloc;
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/get_validation_details_entitie_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/ticket_classification_entitie_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/repositories/common_ticket_classification_repository.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/get_validation_details_bloc/get_validation_details_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_action_bloc/ticket_classification_action_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/update_classification_validation_bloc/update_classification_validation_bloc.dart';
import 'package:support_bot_dashboard/utils/applications_pluto_helper_methods.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
import 'package:support_bot_dashboard/utils/service/instance_sharing_service.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';
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
    final TicketClassificationEntitieModel? ticketClassificationEntitieModel;
    final rowData =
        rendererContext.row.cells.map((key, cell) => MapEntry(key, cell.value));
    final actionData =
        rendererContext.row.cells["action"]?.value as Map<String, dynamic>? ??
            {};
    final isUpdatedToHubspot = actionData["isUpdatedToHubspot"] ?? "";
    final id = rowData['id'] ?? '';
    final classification = rowData['classification'] ?? 'N/A';
    return BlocConsumer<TicketClassificationTabBloc, TicketClassificationState>(
      listener: (context, state) {
        if (state is TicketClassificationActionSucssesState) {
          BlocProvider.of<TicketClassificationTabBloc>(context)
              .add(TicketClassificationDataCallEvent(
            startDate: DateTime.now().subtract(const Duration(days: 7)),
            endDate: DateTime.now(),
            page: 1,
            pageSize: 10,
          ));
        }
      },
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
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.white,
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 500),
                              padding: const EdgeInsets.all(16.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Ticket details",
                                        style: SupportBotTextstyle.columnHeading
                                            .copyWith(fontSize: 20),
                                      ),
                                    ),
                                    UIHelpers.verticalSpaceSmall,
                                    const Divider(),
                                    UIHelpers.verticalSpaceSmall,
                                    ...rowData.entries.map((entry) {
                                      if (entry.key.toLowerCase() == "action") {
                                        return const SizedBox.shrink();
                                      }

                                      String capitalizedKey = entry.key
                                          .split('_')
                                          .join(' ')
                                          .split(' ')
                                          .map((word) => word.isNotEmpty
                                              ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                                              : '')
                                          .join(' ');

                                      bool isEmpty =
                                          (entry.value?.toString() ?? '')
                                              .isEmpty;
                                      String value = isEmpty
                                          ? 'N/A'
                                          : entry.value.toString();

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "$capitalizedKey: ",
                                            style: SupportBotTextstyle
                                                .columnHeading,
                                          ),
                                          UIHelpers.verticalSpaceTiny,
                                          Text(
                                            value,
                                            style: isEmpty
                                                ? SupportBotTextstyle
                                                    .cellHeading
                                                    .copyWith(
                                                        color: Colors.black54,
                                                        fontStyle:
                                                            FontStyle.italic)
                                                : SupportBotTextstyle
                                                    .cellHeading,
                                          ),
                                          UIHelpers.verticalSpaceRegular,
                                        ],
                                      );
                                    }).toList(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.cancel,
                                              color:
                                                  SupportBotColors.bluePrimary),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 15),
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: SupportBotColors
                                                      .bluePrimary),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          label: const Text(
                                            "Close",
                                            style: TextStyle(
                                                color: SupportBotColors
                                                    .bluePrimary),
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
                    });
                  },
                  child: BlocProvider(
                    create: (context) => TicketClassificationActionBloc(),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.visibility,
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
                if (isUpdatedToHubspot == true)
                  PopupMenuItem<String>(
                    value: S.of(context).revert,
                    child: InkWell(
                      onTap: () {
                        if (isUpdatedToHubspot) {
                          BlocProvider.of<TicketClassificationTabBloc>(context)
                              .add(RevertClassificationEvent(
                            ticketId: id,
                          ));

                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            BlocProvider.of<TicketClassificationTabBloc>(
                                    context)
                                .add(
                              TicketClassificationDataCallEvent(
                                startDate: DateTime.now()
                                    .subtract(const Duration(days: 7)),
                                endDate: DateTime.now(),
                                page: 1,
                                pageSize: 10,
                              ),
                            );
                          });
                          Navigator.of(context).pop();
                          // _showRevertToHubspotPopup(
                          //     context, S.of(context).revertSuccess);
                        } else {
                          _showRevertToHubspotPopup(
                              context, S.of(context).noRevert);
                        }
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.loop_rounded),
                          UIHelpers.horizontalSpaceTiny,
                          Text(S.of(context).revert),
                        ],
                      ),
                    ),
                  ),
                if (isUpdatedToHubspot == false)
                  PopupMenuItem<String>(
                    value: "Update",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<TicketClassificationTabBloc>(
                                context),
                            child: AlertDialog(
                              title: const Text("Update Ticket"),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Do you Want to Mark This Ticket as a Contact ${classification} in HubSpot",
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
                                    backgroundColor:
                                        SupportBotColors.bluePrimary,
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
                                  child: BlocBuilder<
                                      TicketClassificationActionBloc,
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

                                            final ticketId =
                                                rowData['id'] ?? '';

                                            context
                                                .read<
                                                    TicketClassificationActionBloc>()
                                                .add(
                                                  TicketClassificationActionOnEvent(
                                                    classification:
                                                        classification,
                                                    ticketId: ticketId,
                                                  ),
                                                );

                                            BlocProvider.of<
                                                        TicketClassificationTabBloc>(
                                                    context)
                                                .add(
                                                    TicketClassificationDataCallEvent(
                                              startDate: DateTime.now()
                                                  .subtract(
                                                      const Duration(days: 7)),
                                              endDate: DateTime.now(),
                                              page: 1,
                                              pageSize: 10,
                                            ));

                                            Navigator.of(context).pop();
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                SupportBotColors.bluePrimary,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14.0,
                                                horizontal: 24.0),
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
                                                  classification:
                                                      classification,
                                                  ticketId: ticketId,
                                                ),
                                              );

                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            BlocProvider.of<
                                                        TicketClassificationTabBloc>(
                                                    context)
                                                .add(
                                              TicketClassificationDataCallEvent(
                                                startDate: DateTime.now()
                                                    .subtract(const Duration(
                                                        days: 7)),
                                                endDate: DateTime.now(),
                                                page: 1,
                                                pageSize: 10,
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          });
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
                            ),
                          );
                        },
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.update,
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

  static _showRevertToHubspotPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).statusUpdated),
          content: Text(message),
          actions: <Widget>[
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
                Future.delayed(const Duration(milliseconds: 500), () {
                  BlocProvider.of<TicketClassificationTabBloc>(context).add(
                    TicketClassificationDataCallEvent(
                      startDate:
                          DateTime.now().subtract(const Duration(days: 7)),
                      endDate: DateTime.now(),
                      page: 1,
                      pageSize: 10,
                    ),
                  );
                  Navigator.of(context).pop();
                });
                Navigator.of(context).pop();
              },
              child: Text(
                S.of(context).ok,
                style: SupportBotTextstyle.hint.copyWith(
                  color: SupportBotColors.white,
                ),
              ),
            ),
          ],
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
    final idMap = rowData.cells['id']?.value;
    final id = idMap != null && idMap is Map<String, dynamic>
        ? idMap['id']?.toString() ?? 'N/A'
        : 'N/A';
    final validationStatus =
        rowData.cells['validation_status']?.value == "Validated";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: SupportBotColors.white,
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
                                agentAnsValidation: validationStatus,
                                ticketId: id.toString() ?? "",
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
    List<String> piplineid = const [],
  }) {
    final rowData =
        rendererContext.row.cells.map((key, cell) => MapEntry(key, cell.value));
    String? selectedValue;
    final Id = rowData['id'] ?? "";
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
            if (state is UpdateClassificationValidationSucssesState) {
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
                      reason: "",
                      validatedClassification: newValue?.toLowerCase() ?? '',
                      validation: newValue?.toLowerCase(),
                    ),
                  );
                  Future.delayed(const Duration(microseconds: 500), () {
                    BlocProvider.of<TicketClassificationTabBloc>(context)
                        .add(TicketClassificationDataCallEvent(
                      startDate:
                          DateTime.now().subtract(const Duration(days: 7)),
                      endDate: DateTime.now(),
                      page:
                          BlocProvider.of<TicketClassificationTabBloc>(context)
                              .page,
                      pageSize:
                          BlocProvider.of<TicketClassificationTabBloc>(context)
                              .pageSize,
                    ));
                  });

                  if (state is GetValidationDetailsSucssesState &&
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
                                    id: Id,
                                    pipeline: (piplineid).join(','),
                                    reason: reason,
                                    validatedClassification:
                                        _selectedClassification,
                                    validation: newValue?.toLowerCase(),
                                  ),
                                );
                                Future.delayed(
                                    const Duration(microseconds: 200000), () {
                                  BlocProvider.of<TicketClassificationTabBloc>(
                                          context)
                                      .add(
                                    TicketClassificationDataCallEvent(
                                      startDate: DateTime.now()
                                          .subtract(const Duration(days: 7)),
                                      endDate: DateTime.now(),
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

                                if (state is GetValidationDetailsSucssesState &&
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

  static void showTicketDetailsDialog(
    BuildContext context, {
    required PlutoRow rowData,
  }) {
    TextEditingController aiQueryController = TextEditingController(
        text:
            rowData.cells['ai_query_answer']?.value ?? "Answer not generated");
    bool isEditing = false;

    final idMap = rowData.cells['id']?.value;
    final id = idMap != null && idMap is Map<String, dynamic>
        ? idMap['id']?.toString() ?? 'N/A'
        : 'N/A';

    final ticketDescription =
        (rowData.cells['ticket_description']?.value).toString() ?? "";
    final answeredStatus =
        (rowData.cells['classification']?.value).toString() ?? '';
    final validationStatus =
        rowData.cells['validation_status']?.value ?? "Not Validated";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
                      Text(id.toString() ?? '',
                          style: SupportBotTextstyle.cellHeading),
                      UIHelpers.verticalSpaceRegular,
                      Text(
                        "Ticket Description: ",
                        style: SupportBotTextstyle.columnHeading,
                      ),
                      UIHelpers.verticalSpaceTiny,
                      Text(
                        ticketDescription,
                        style: SupportBotTextstyle.cellHeading,
                      ),
                      UIHelpers.verticalSpaceMedium,
                      Text(
                        "Answer Status: ",
                        style: SupportBotTextstyle.columnHeading,
                      ),
                      UIHelpers.verticalSpaceTiny,
                      Text(
                        answeredStatus,
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
                        validationStatus,
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
                                                ticketId: id.toString() ?? '',
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
                                          ticketId: id.toString() ?? '',
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

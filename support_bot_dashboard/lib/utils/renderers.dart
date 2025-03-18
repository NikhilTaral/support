
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/domain/entities/ai_query_answer_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart'
    as ticketClassificationBloc;
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/get_all_validatod_user_bloc/get_all_validation_user_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/get_validation_details_bloc/get_validation_details_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/update_classification_validation_bloc/update_classification_validation_bloc.dart';
import 'package:support_bot_dashboard/utils/ai_quiery_action_view.dart';
import 'package:support_bot_dashboard/utils/applications_pluto_helper_methods.dart';
import 'package:support_bot_dashboard/utils/common_widgets/validation_drop_down_show_dialog.dart';
import 'package:support_bot_dashboard/utils/ticket_classification_renderer.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
import 'package:support_bot_dashboard/utils/service/instance_sharing_service.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class Renderers {
  static TextStyle frozenStyle(
    PlutoColumnRendererContext rendererContext,
    TextStyle textStyle,
  ) {
    if (rendererContext.cell.column.frozen == PlutoColumnFrozen.start ||
        rendererContext.cell.column.frozen == PlutoColumnFrozen.end) {}
    return textStyle;
  }

  static Widget statusRenderer(PlutoColumnRendererContext context) {
    final bool? value = context.cell.value;

    final String displayText = value == true ? 'Updated' : 'Not Updated';

    return Center(child: Text(displayText));
  }

  static Widget textRenderer1(
    PlutoColumnRendererContext rendererContext, {
    TextStyle? textStyle,
  }) {
    final String text = rendererContext.cell.value ?? "";
    textStyle ??= frozenStyle(
        rendererContext,
        SupportBotTextstyle.small
            .copyWith(fontSize: 14, color: SupportBotColors.gray.shade800));

    return Text(
      text.isEmpty ? "Not Classified" : text,
      textAlign: TextAlign.start,
      style: textStyle,
      overflow: TextOverflow.ellipsis,
    );
  }

//
  static Widget textRenderer2(
    PlutoColumnRendererContext rendererContext, {
    TextStyle? textStyle,
  }) {
    final String text = rendererContext.cell.value ?? "";
    textStyle ??= frozenStyle(
      rendererContext,
      SupportBotTextstyle.small.copyWith(
        fontSize: 14,
        color: SupportBotColors.gray.shade800,
      ),
    );

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
        color: value > 5 ? const Color(0xFF11972C) : const Color(0xFFFD0101),
      ),
    );

    return Text("$value/10", style: textStyle);
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
      ),
    );

    return Text(displayText, style: textStyle);
  }

  static Widget ticketClassificationActionRenderer(
    PlutoColumnRendererContext rendererContext, {
    required BuildContext context,
    void Function(String?)? onDelete,
  }) {
    final rowData = rendererContext.row.cells.map(
      (key, cell) => MapEntry(key, cell.value),
    );
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
    List<AiQueryAttributeItem> allRows =
        rendererContext.cell.value?['allRows'] ?? [];
    return Align(
      alignment: Alignment.topLeft,
      child: _buildViewValidateButton(rendererContext, allRows, index),
    );
  }

  static Widget _buildViewValidateButton(
    PlutoColumnRendererContext rendererContext,
    List<AiQueryAttributeItem> allRows,
    int index,
  ) {
    return PopupMenuTheme(
      data: const PopupMenuThemeData(color: SupportBotColors.white),
      child: PopupMenuButton(
        tooltip: "",
        icon: const Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Icon(Icons.more_vert_rounded),
        ),
        itemBuilder: (context) => [
          _buildMenuItem(
            icon: Icons.visibility,
            text: serviceLocator<S>().view,
            onTap: () => _showDialog(
              context,
              TicketDetailsDialog(
                rowData: rendererContext.row,
                allRows: allRows,
                initialIndex: index,
              ),
            ),
          ),
          _buildMenuItem(
            icon: Icons.loop_rounded,
            text: serviceLocator<S>().validate,
            onTap: () => _showDialog(
              context,
              ValidateAnswerDialog(rowData: rendererContext.row),
            ),
          ),
        ],
      ),
    );
  }

  static PopupMenuItem _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return PopupMenuItem(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon),
          UIHelpers.horizontalSpaceTiny,
          Text(
            text,
            style: SupportBotTextstyle.small.copyWith(
              color: SupportBotColors.gray.shade800,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  static void _showDialog(BuildContext context, Widget dialog) {
    showDialog(context: context, builder: (context) => dialog);
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
    final rowData = rendererContext.row.cells.map(
      (key, cell) => MapEntry(key, cell.value),
    );

    if (rowData['validation'] == "") {
      return Center(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => GetValidationDetailsBloc()),
            BlocProvider(
              create: (context) => UpdateClassificationValidationBloc(),
            ),
            BlocProvider(create: (context) => GetAllValidationUsersBloc()),
          ],
          child:
              BlocConsumer<GetValidationDetailsBloc, GetValidationDetailsState>(
            listener: (context, state) {
              if (state is UpdateClassificationValidationSuccessState) {
                serviceLocator<InstanceSharingService>()
                    .ticketClassificationBloc
                    ?.add(
                      ticketClassificationBloc.TickiteClassificationEvent(),
                    );
              }
            },
            builder: (context, state) {
              return _validateButton(
                context,
                state,
                rowData,
                rendererContext,
                piplineid,
              );
            },
          ),
        ),
      );
    } else {
      return Center(child: Text(rendererContext.cell.value));
    }
  }
}

Widget _validateButton(
  context,
  state,
  rowData,
  rendererContext,
  piplineid,
) {
  final id = rowData['id'] ?? "";
  final List<String> items = ['Correct', 'Incorrect'];
  String? selectedValue;
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
      BlocProvider.of<GetValidationDetailsBloc>(
        context,
      ).add(GetValidationDetailsvalidateEvent(id: rowData['id']));
    },
    dropdownColor: SupportBotColors.white,
    underline: Container(color: Colors.transparent),
    value: selectedValue,
    hint: Text(selectedValue ?? 'Select'),
    items: items.map((String value) {
      return DropdownMenuItem<String>(value: value, child: Text(value));
    }).toList(),
    onChanged: (String? newValue) {
      if (newValue?.toLowerCase() == "correct") {
        final rowData = rendererContext.row.cells.map(
          (key, cell) => MapEntry(key, cell.value),
        );

        bool validationValue = newValue?.toLowerCase() == 'correct';

        BlocProvider.of<UpdateClassificationValidationBloc>(context).add(
          UpdateClassificationValidationstateEvent(
            id: rowData['id'],
            pipeline: (piplineid).join(','),
            validation: newValue?.toLowerCase(),
          ),
        );
        final states =
            BlocProvider.of<UpdateClassificationValidationBloc>(context).state;
        if (states is UpdateClassificationValidationSuccessState) {}
        Future.delayed(const Duration(microseconds: 2000000), () {
          final bloc = BlocProvider.of<TicketClassificationTabBloc>(context);
          BlocProvider.of<TicketClassificationTabBloc>(context).add(
            TicketClassificationDataCallEvent(
              startDate: bloc.startDate,
              endDate: bloc.endDate,
              fieldValue: bloc.selectedPipelineId,
              page: bloc.page,
              pageSize: bloc.pageSize,
            ),
          );

          BlocProvider.of<GetAllValidationUsersBloc>(context).add(
            GetValidationUsersInitialEvent(
              startDate: bloc.startDate,
              endDate: bloc.endDate,
              filter: [bloc.selectedPipelineId],
            ),
          );
        });

        if (state is GetValidationDetailsSuccessState &&
            state.getValidationDetailsAttributeModel?.data?.status == false) {
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
        showClassificationDialog(
          context: context,
          id: id,
          pipelineIds: piplineid,
          newValue: newValue,
        );
      }
    },
    disabledHint: Text(s.noSelectionText),
  );
}

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_accuracy_and_validation_trends_bloc.dart/ai_accuracy_and_validation_trends_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_answer_bloc/ai_query_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_edited_bloc/ai_query_edited_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/get_ai_reponse_stat_bloc/get_ai_response_stat_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/get_all_pipeline_bloc/get_all_pipeline_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_tile_bloc/pipeline_tile_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/user_validation_bloc/user_validation_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/validation_status_bloc/validation_status_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/multipal_pipeline_Widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class HomeFiltersWidget extends StatefulWidget {
  const HomeFiltersWidget(
      {super.key,
      this.pipelineName,
      this.endDate,
      this.piplineId,
      this.startDate});
  final String? pipelineName;
  final List<String>? piplineId;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  _HomeFiltersWidgetState createState() => _HomeFiltersWidgetState();
}

class _HomeFiltersWidgetState extends State<HomeFiltersWidget> {
  final ValueNotifier<List<DateTime>?> selectedDatesNotifier =
      ValueNotifier<List<DateTime>?>(null);
  List<DateTime?> selectedate = [];
  List<String> selectedItems = [];
  List<String> pipelineIds = [];

  @override
  void initState() {
    super.initState();
    if (widget.pipelineName != null) {
      selectedItems.clear();
      selectedItems.add(widget.pipelineName ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllPipelineBloc, GetAllPipelineState>(
      builder: (context, state) {
        if (state is GetAllAllPipelineSuccessState) {
          List<GetAllPipelineData> items = state.attributeModel?.data ?? [];
          return _buildFiltersRow(items);
        } else if (state is GetAllPipelineLoadingState) {
          return _buildLoadingState();
        } else if (state is GetAllPipelineFailureState) {
          return FailureWidget(
            onTap: () {
              BlocProvider.of<GetAllPipelineBloc>(context)
                  .add(GetAllPiplineInitialEvent());
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildFiltersRow(List<GetAllPipelineData> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: Row(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildPipelineDropdown(items),
              _buildDateRangeSelector(),
              _buildApplyFilterButton(),
              // _buildClearFilterButton()
            ],
          ),
        ),
        UIHelpers.verticalSpaceTiny,
        _buildChips(context)
      ],
    );
  }

  Widget _buildPipelineDropdown(List<GetAllPipelineData> items) {
    final s = serviceLocator<S>();
    return Container(
      constraints: const BoxConstraints(maxWidth: 420),
      child: DropdownWithCheckbox(
        hintText: s.pipelineText,
        items: items,
        selectedItems: selectedItems,
        onChanged: (value) => _onPipelineSelectionChanged(value ?? [], items),
      ),
    );
  }

  Widget _buildDateRangeSelector() {
    if (selectedate.isNotEmpty) {
      final endDate = selectedate.lastOrNull ?? DateTime.now();
      final startDate = selectedate.firstOrNull ?? DateTime.now();
      selectedate = [startDate, endDate];
    }

    return Center(
      child: ValueListenableBuilder<List<DateTime>?>(
        valueListenable: selectedDatesNotifier,
        builder: (context, selectedDates, child) {
          final DateTime endDate;
          final DateTime startDate;

          if (selectedDates?.isNotEmpty == true) {
            startDate = selectedDates![0];
            endDate = selectedDates.length > 1 ? selectedDates[1] : startDate;
          } else {
            endDate = widget.endDate ?? DateTime.now();
            startDate = widget.startDate ?? DateTime.now();
          }

          return SizedBox(
            height: 180,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: SupportBotColors.bluePrimary),
                padding: const EdgeInsets.only(
                  right: 6,
                  left: 6,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => _pickDateRange(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: SupportBotColors.bluePrimary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${DateFormat('MMM dd').format(startDate)} - ${DateFormat('MMM dd yyyy').format(endDate)}',
                    style: SupportBotTextstyle.normal.copyWith(
                      fontSize: 14,
                      color: SupportBotColors.bluePrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildApplyFilterButton() {
    final s = serviceLocator<S>();
    return SizedBox(
      height: 180,
      child: ElevatedButton.icon(
        onPressed: _addEvents,
        icon: const Icon(SupportBotIcons.filter, color: Colors.white),
        label: Text(
          s.filterApplyText,
          style: const TextStyle(
            color: SupportBotColors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: SupportBotColors.bluePrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Row(
      spacing: 15,
      children: [
        LoadingWidget(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            height: 40,
            width: 450),
        LoadingWidget(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            height: 40,
            width: 180),
        LoadingWidget(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            height: 40,
            width: 130),
      ],
    );
  }

  Future<void> _pickDateRange() async {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
      dayTextStyle: SupportBotTextstyle.hint
          .copyWith(color: SupportBotColors.black, fontWeight: FontWeight.w700),
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: SupportBotColors.bluePrimary,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: SupportBotTextstyle.hint
          .copyWith(color: SupportBotColors.black, fontWeight: FontWeight.bold),
      selectableDayPredicate: (date) => date.isBefore(DateTime.now()),
    );

    final pickedDates = await showCalendarDatePicker2Dialog(
      context: context,
      config: config,
      dialogSize: const Size(400, 400),
      borderRadius: BorderRadius.circular(15),
      value: selectedDatesNotifier.value?.cast<DateTime?>() ?? [],
      dialogBackgroundColor: Colors.white,
    );

    if (pickedDates != null) {
      selectedDatesNotifier.value = pickedDates.cast<DateTime>();
      selectedate = pickedDates;
    }
  }

  void _onPipelineSelectionChanged(
      List<String> selectedNames, List<GetAllPipelineData> items) {
    pipelineIds.clear();
    for (var selectedName in selectedNames) {
      final matchingItem = items.firstWhere(
        (item) => item.pipelineName == selectedName,
        orElse: () => GetAllPipelineData(pipelineName: '', pipelineId: ''),
      );
      if (matchingItem.pipelineId?.isNotEmpty == true) {
        pipelineIds.add(matchingItem.pipelineId ?? "");
      }
    }
    setState(() {
      selectedItems = selectedNames;
    });
  }

  Future<void> showSnackbar(BuildContext context, String text) async {
    final snackBar = SnackBar(
      backgroundColor: SupportBotColors.blueSecondary.shade100,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_active,
                color: SupportBotColors.bluePrimary.shade400,
              ),
              UIHelpers.horizontalSpaceSmall,
              Text(
                text,
                textAlign: TextAlign.center,
                style: SupportBotTextstyle.small,
              ),
            ],
          ),
          SnackBarAction(
            label: 'X',
            textColor: SupportBotColors.blueSecondary.shade500,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 300, vertical: 20),
      duration: const Duration(seconds: 5),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _addEvents() {
    final s = serviceLocator<S>();
    final selectedPipelineValue =
        pipelineIds.isEmpty ? widget.piplineId : pipelineIds;

    if (selectedPipelineValue?.isEmpty == true) {
      showSnackbar(
        context,
        s.filterApplySnackBarText,
      );
      return;
    }

    if (selectedItems.isNotEmpty) {
      BlocProvider.of<ValidationStatusBloc>(context).selectedPipelineId =
          selectedPipelineValue;
      BlocProvider.of<ValidationStatusBloc>(context)
          .add(ValidationStatuseCallEvent(
        endDate: selectedate.lastOrNull ?? widget.endDate,
        startDate: selectedate.firstOrNull ?? widget.startDate,
        selectedPipelineValue: selectedPipelineValue,
      ));

      BlocProvider.of<AiQueryAnswerBloc>(context).selectedPipelineId =
          selectedPipelineValue;
      BlocProvider.of<AiQueryAnswerBloc>(context).add(AIQueryAnswerInitialEvent(
        endDate: selectedate.lastOrNull ?? widget.endDate,
        startDate: selectedate.firstOrNull ?? widget.startDate,
        selectedPipelineValue: selectedPipelineValue,
      ));

      BlocProvider.of<AiQueryEditedBloc>(context).selectedPipelineId =
          selectedPipelineValue;
      BlocProvider.of<AiQueryEditedBloc>(context).add(AIQueryEditedInitialEvent(
        endDate: selectedate.lastOrNull ?? widget.endDate,
        startDate: selectedate.firstOrNull ?? widget.startDate,
        selectedPipelineValue: selectedPipelineValue,
      ));
      BlocProvider.of<TicketClassificationBloc>(context).selectedPipelineId =
          selectedPipelineValue;
      BlocProvider.of<TicketClassificationBloc>(context)
          .add(TickiteClassificationEvent(
        endDate: selectedate.lastOrNull ?? widget.endDate,
        startDate: selectedate.firstOrNull ?? widget.startDate,
        selectedPipelineValue: selectedPipelineValue,
      ));

      BlocProvider.of<UserValidationBloc>(context).selectedPipelineId =
          selectedPipelineValue;
      BlocProvider.of<UserValidationBloc>(context).add(UserValidationsEvent(
        endDate: selectedate.lastOrNull ?? widget.endDate,
        startDate: selectedate.firstOrNull ?? widget.startDate,
        selectedPipelineValue: selectedPipelineValue,
      ));
      BlocProvider.of<AiAccuracyAndValidationTrendsBloc>(context)
          .add(AiAccuracyAndValidationTrendsIntialEvent(
        endDate: selectedate.lastOrNull?.toIso8601String() ??
            widget.endDate?.toIso8601String(),
        startDate: selectedate.firstOrNull?.toIso8601String() ??
            widget.startDate?.toIso8601String(),
        piplineId: selectedPipelineValue,
      ));

      BlocProvider.of<PipelineTileBloc>(context).add(PipelineTileInitialEvent(
        endDate: selectedate.lastOrNull ?? widget.endDate,
        startDate: selectedate.firstOrNull ?? widget.startDate,
      ));

      BlocProvider.of<GetAiResponseStatBloc>(context).add(
          GetAiResponseStatInitialEvent(
              endDate: selectedate.lastOrNull ?? widget.endDate,
              startDate: selectedate.firstOrNull ?? widget.startDate,
              selectedPipelineValue: widget.piplineId));
    }
  }

  Widget _buildChips(BuildContext context) {
    final s = serviceLocator<S>();
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: [
        ...selectedItems.take(2).map((item) => Chip(
              backgroundColor: SupportBotColors.bluePrimary,
              label: Text(
                item,
                style: const TextStyle(color: SupportBotColors.white),
              ),
              deleteIcon: const Icon(
                SupportBotIcons.close,
                color: SupportBotColors.white,
              ),
              onDeleted: () {
                setState(() {
                  int index = selectedItems.indexOf(item);

                  if (index >= 0) {
                    if (index < pipelineIds.length) {
                      pipelineIds.removeAt(index);
                    }
                    selectedItems.removeAt(index);
                  }
                  if (selectedItems.isEmpty) {
                    showSnackbar(context, s.filterApplySnackBarText);
                    pipelineIds.clear();
                  }
                });
              },
            )),
        if (selectedItems.length > 2) ...[
          ActionChip(
            label: const Text(
              "...",
              style: TextStyle(color: SupportBotColors.white),
            ),
            backgroundColor: SupportBotColors.bluePrimary,
            onPressed: () {},
          ),
          ActionChip(
            label: Text(
              "+${selectedItems.length - 2}",
              style: SupportBotTextstyle.cellHeading.copyWith(
                color: SupportBotColors.white,
              ),
            ),
            backgroundColor: SupportBotColors.bluePrimary,
            onPressed: () {},
          ),
        ],
      ],
    );
  }
}

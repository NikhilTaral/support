import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_answer_bloc/ai_query_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_edited_bloc/ai_query_edited_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/get_all_pipeline_bloc/get_all_pipeline_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/user_validation_bloc/user_validation_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/validation_status_bloc/validation_status_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/multipal_pipeline_Widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class HomeFiltersWidget extends StatefulWidget {
  const HomeFiltersWidget({super.key});

  @override
  _HomeFiltersWidgetState createState() => _HomeFiltersWidgetState();
}

class _HomeFiltersWidgetState extends State<HomeFiltersWidget> {
  final ValueNotifier<List<DateTime>?> selectedDatesNotifier =
      ValueNotifier<List<DateTime>?>(null);
  List<String> selectedItems = [];
  List<String> pipelineIds = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllPipelineBloc, GetAllPipelineState>(
      builder: (context, state) {
        if (state is GetAllAllPipelineSuccessState) {
          List<Datums> items = state.attributeModel?.data ?? [];
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

  Widget _buildFiltersRow(List<Datums> items) {
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
            ],
          ),
        ),
        UIHelpers.verticalSpaceTiny,
        _buildChips(context)
      ],
    );
  }

  Widget _buildPipelineDropdown(List<Datums> items) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 420),
      child: DropdownWithCheckbox(
        hintText: "Pipeline type",
        items: items,
        selectedItems: selectedItems,
        onChanged: (value) => _onPipelineSelectionChanged(value ?? [], items),
      ),
    );
  }

  Widget _buildDateRangeSelector() {
    return Center(
      child: ValueListenableBuilder<List<DateTime>?>(
        valueListenable: selectedDatesNotifier,
        builder: (context, selectedDates, child) {
          final startDate =
              selectedDates?.isNotEmpty == true ? selectedDates![0] : null;
          final endDate =
              (selectedDates?.length ?? 0) > 1 ? selectedDates![1] : null;

          return OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: SupportBotColors.bluePrimary),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => _pickDateRange(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_month_outlined,
                    color: SupportBotColors.bluePrimary),
                const SizedBox(width: 8),
                Text(
                  startDate != null && endDate != null
                      ? '${DateFormat('MMM dd').format(startDate)} - ${DateFormat('MMM dd yyyy').format(endDate)}'
                      : '${DateFormat('MMM dd').format(DateTime.now())} - ${DateFormat('MMM dd yyyy').format(DateTime.now())}',
                  style: SupportBotTextstyle.normal.copyWith(
                    fontSize: 14,
                    color: SupportBotColors.bluePrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildApplyFilterButton() {
    return ElevatedButton.icon(
      onPressed: _addEvents,
      icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
      label: const Text('Apply Filter', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
        backgroundColor: SupportBotColors.bluePrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
      dayTextStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: SupportBotColors.bluePrimary,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle:
          const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      selectableDayPredicate: (date) => date.isBefore(DateTime.now()),
    );

    final pickedDates = await showCalendarDatePicker2Dialog(
      context: context,
      config: config,
      dialogSize: const Size(325, 370),
      borderRadius: BorderRadius.circular(15),
      value: selectedDatesNotifier.value?.cast<DateTime?>() ?? [],
      dialogBackgroundColor: Colors.white,
    );

    if (pickedDates != null) {
      selectedDatesNotifier.value = pickedDates.cast<DateTime>();
      final startDate = pickedDates.isNotEmpty ? pickedDates[0] : null;
      final endDate = pickedDates.length > 1 ? pickedDates[1] : null;

      await LocalStorage.saveSelectedDates(startDate, endDate);
    }
  }

  void _onPipelineSelectionChanged(
      List<String> selectedNames, List<Datums> items) {
    pipelineIds.clear();
    for (var selectedName in selectedNames) {
      final matchingItem = items.firstWhere(
        (item) => item.pipelineName == selectedName,
        orElse: () => Datums(pipelineName: '', pipelineId: ''),
      );
      if (matchingItem.pipelineId?.isNotEmpty == true) {
        pipelineIds.add(matchingItem.pipelineId ?? "");
      }
    }
    setState(() {
      selectedItems = selectedNames;
    });
  }

  void _addEvents() {
    final selectedPipelineValue = pipelineIds;
    if (selectedItems.isNotEmpty) {
      BlocProvider.of<ValidationStatusBloc>(context).add(
          ValidationStatuseCallEvent(
              selectedPipelineValue: selectedPipelineValue));
      BlocProvider.of<AiQueryAnswerBloc>(context).add(AIQueryAnswerInitialEvent(
          selectedPipelineValue: selectedPipelineValue));
      BlocProvider.of<AiQueryEditedBloc>(context).add(AIQueryEditedInitialEvent(
          selectedPipelineValue: selectedPipelineValue));
      BlocProvider.of<GetAllPipelineBloc>(context).add(
          GetAllPiplineInitialEvent(
              selectedPipelineValue: selectedPipelineValue));
      BlocProvider.of<TicketClassificationBloc>(context).add(
          TickiteClassificationEvent(
              selectedPipelineValue: selectedPipelineValue));
      BlocProvider.of<UserValidationBloc>(context).add(
          UserValidationsEvent(selectedPipelineValue: selectedPipelineValue));
    }
  }

  Widget _buildChips(BuildContext context) {
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
                  selectedItems.remove(item);
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

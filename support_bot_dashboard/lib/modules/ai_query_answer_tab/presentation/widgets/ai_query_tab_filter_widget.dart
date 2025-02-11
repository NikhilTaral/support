import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/domain/entities/data_module.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/bloc/ai_query_bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/widgets/pipeline_type_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/get_all_pipeline_bloc/get_all_pipeline_bloc.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_month_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';
import 'package:intl/intl.dart';

class AIQueryTabFilterWidget extends StatefulWidget {
  const AIQueryTabFilterWidget({super.key});

  @override
  _AIQueryFilterWidgetState createState() => _AIQueryFilterWidgetState();
}

class _AIQueryFilterWidgetState extends State<AIQueryTabFilterWidget> {
  final ValueNotifier<List<DateTime>?> selectedDatesNotifier =
      ValueNotifier<List<DateTime>?>(null);
  ValueNotifier<String?> classificationNotifier = ValueNotifier<String?>(null);
  String selectedItem = "Expert Care Level 1";
  final DataModule dataModule = DataModule();
  final List<String> pipelineIds = [];
  final s = serviceLocator<S>();
  DateTime? endDate;
  DateTime? startDate;

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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildPipelineDropdown(items),
                _buildDateRangeSelector(),
                _buildClassificationDropdown(),
                _buildApplyFilterButton(),
                _buildClearFilterButton()
              ],
            ),
          ),
        ),
        UIHelpers.verticalSpaceTiny,
        //_buildChips(context, items)
      ],
    );
  }

  Widget _buildPipelineDropdown(List<GetAllPipelineData> items) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 420),
      child: PipelineTypeWidget(
        selectedItem: selectedItem,
        hintText: s.piplineText,
        items: items,
        onChanged: (value) => _onPipelineSelectionChanged(value ?? "", items),
      ),
    );
  }

  Widget _buildDateRangeSelector() {
    if (selectedDatesNotifier.value == null) {
      final endDate = selectedDatesNotifier.value?.lastOrNull ?? DateTime.now();
      final startDate =
          selectedDatesNotifier.value?.firstOrNull ?? DateTime.now();
      selectedDatesNotifier.value = [startDate, endDate];
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
            endDate = DateTime.now();
            startDate = endDate.subtract(const Duration(days: 0));
          }

          return SizedBox(
            height: 180,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: SupportBotColors.bluePrimary),
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
                    '${DateFormat('MMM dd').format(startDate)} - ${DateFormat('MMM dd yyyy').format(endDate)}',
                    style: SupportBotTextstyle.normal.copyWith(
                      fontSize: 14,
                      color: SupportBotColors.bluePrimary,
                      fontWeight: FontWeight.w500,
                    ),
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
    return SizedBox(
      height: 180,
      child: ElevatedButton.icon(
        onPressed: _addEvents,
        icon: const Icon(SupportBotIcons.filter, color: Colors.white),
        label: Text(s.filterApplyText,
            style: SupportBotTextstyle.countLabel
                .copyWith(color: SupportBotColors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: SupportBotColors.bluePrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  Widget _buildClearFilterButton() {
    return SizedBox(
      height: 180,
      child: ElevatedButton.icon(
        onPressed: () async {
          setState(() {
            classificationNotifier = ValueNotifier<String?>(null);
            selectedItem = "Expert Care Level 1";

            selectedDatesNotifier.value = null;
            pipelineIds.clear();
          });
          BlocProvider.of<AiQueryBloc>(context).piplineID = ["11257490"];
          BlocProvider.of<AiQueryBloc>(context).endDate = DateTime.now()
              .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
          BlocProvider.of<AiQueryBloc>(context).startDate = DateTime.now()
              .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
          ;

          BlocProvider.of<AiQueryBloc>(context).add(AIQueryInitialEvent());
        },
        icon: const Icon(Icons.clear_all, color: Colors.white),
        label: Text(s.filterClearText, style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.redAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
      dialogSize: const Size(400, 400),
      borderRadius: BorderRadius.circular(15),
      value: selectedDatesNotifier.value?.cast<DateTime?>() ?? [],
      dialogBackgroundColor: Colors.white,
    );

    if (pickedDates != null) {
      selectedDatesNotifier.value = pickedDates.cast<DateTime>();
      startDate =
          pickedDates.isNotEmpty ? (pickedDates[0] ?? startDate) : startDate;
      endDate = pickedDates.length > 1 ? (pickedDates[1] ?? endDate) : endDate;
    }
  }

  void _onPipelineSelectionChanged(
      String? selectedName, List<GetAllPipelineData> items) {
    pipelineIds.clear();
    final matchingItem = items.firstWhere(
      (item) => item.pipelineName == selectedName,
      orElse: () => GetAllPipelineData(pipelineName: '', pipelineId: ''),
    );
    if (matchingItem.pipelineId?.isNotEmpty == true) {
      pipelineIds.add(matchingItem.pipelineId ?? "");
    }
    setState(() {
      selectedItem = selectedName ?? "";
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
    final selectedPipelineValue =
        pipelineIds.isEmpty ? ["11257490"] : pipelineIds;

    if (selectedPipelineValue.isEmpty) {
      showSnackbar(
        context,
        s.filterApplySnackBarText,
      );
      return;
    }

    if (selectedItem.isNotEmpty) {
      BlocProvider.of<AiQueryBloc>(context).add(AIQueryInitialEvent(
        selectedPipelineValueList: selectedPipelineValue,
        classificationFilterValue: classificationNotifier.value,
        startDate: startDate,
        endDate: endDate,
        page: 1,
        pageSize: 10,
      ));
    }
  }

  // Keep this code for further requirements
  // Widget _buildChips(BuildContext context, List<Datums> items) {
  //   return Wrap(
  //     alignment: WrapAlignment.start,
  //     spacing: 8,
  //     runSpacing: 8,
  //     children: [
  //       ...selectedItems.take(2).map((item) => Chip(
  //             backgroundColor: SupportBotColors.bluePrimary,
  //             label: Text(
  //               item,
  //               style: const TextStyle(color: SupportBotColors.white),
  //             ),
  //             deleteIcon: const Icon(
  //               SupportBotIcons.close,
  //               color: SupportBotColors.white,
  //             ),
  //             onDeleted: () {
  //               setState(() {
  //                 selectedItems.remove(item);
  //               });
  //               _onPipelineSelectionChanged(selectedItems ?? [], items);
  //             },
  //           )),
  //       if (selectedItems.length > 2) ...[
  //         ActionChip(
  //           label: const Text(
  //             "...",
  //             style: TextStyle(color: SupportBotColors.white),
  //           ),
  //           backgroundColor: SupportBotColors.bluePrimary,
  //           onPressed: () {},
  //         ),
  //         ActionChip(
  //           label: Text(
  //             "+${selectedItems.length - 2}",
  //             style: SupportBotTextstyle.cellHeading.copyWith(
  //               color: SupportBotColors.white,
  //             ),
  //           ),
  //           backgroundColor: SupportBotColors.bluePrimary,
  //           onPressed: () {},
  //         ),
  //       ],
  //     ],
  //   );
  // }

  Widget _buildClassificationDropdown() {
    return SizedBox(
      width: 200,
      child: ValueListenableBuilder(
        valueListenable: classificationNotifier,
        builder: (context, value, child) {
          return CustomMonthDropdown(
            label: classificationNotifier.value ?? s.classification,
            selectedValue: "",
            onChanged: (value) {
              classificationNotifier.value = value;
            },
            items: const ["Answered", "Not Answered"],
          );
        },
      ),
    );
  }
}

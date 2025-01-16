import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/get_all_pipeline_bloc/get_all_pipeline_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/bops_states_bloc/bops_states_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/widgets/ticket_classification_pipeline_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_month_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';
import 'package:intl/intl.dart';

class TicketClassificationFiltersWidget extends StatefulWidget {
  const TicketClassificationFiltersWidget({super.key});

  @override
  _HomeFiltersWidgetState createState() => _HomeFiltersWidgetState();
}

class _HomeFiltersWidgetState extends State<TicketClassificationFiltersWidget> {
  final ValueNotifier<List<DateTime>?> selectedDatesNotifier =
      ValueNotifier<List<DateTime>?>(null);

  String selectedValue = '';
  String bopsState = '';
  String selectedItem = '';
  String validation = '';
  List<String> pipelineIds = [];
  String selectedPipeline = "";

  @override
  void initState() {
    super.initState();
    _loadPipelineIds();
  }

  Future<void> _loadPipelineIds() async {
    final savedPipelineIds = await LocalStorage.getPipelineIds();
    setState(() {
      pipelineIds = savedPipelineIds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BopsStatesBloc()..add(BopsStateDataEvent()),
      child: BlocBuilder<GetAllPipelineBloc, GetAllPipelineState>(
        builder: (context, state) {
          if (state is GetAllAllPipelineSuccessState) {
            List<Datums> items = state.attributeModel?.data ?? [];
            return _buildFiltersRow(items);
          } else if (state is GetAllPipelineLoadingState) {
            return _buildLoadingState();
          } else if (state is GetAllPipelineFailureState) {
            return const Center(child: Text("No data Found"));
          }
          return const Center(child: Text("No data Found"));
        },
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
            width: 180),
        LoadingWidget(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            height: 40,
            width: 180),
        LoadingWidget(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            height: 40,
            width: 150),
        LoadingWidget(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            height: 40,
            width: 130),
        LoadingWidget(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            height: 40,
            width: 130),
        LoadingWidget(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            height: 40,
            width: 130),
      ],
    );
  }

  Widget _buildFiltersRow(List<Datums> items) {
    return SizedBox(
      height: 40,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildPipelineDropdown(items),
            UIHelpers.horizontalSpaceRegular,
            _buildDateRangeSelector(),
            UIHelpers.horizontalSpaceRegular,
            _BopsState(),
            UIHelpers.horizontalSpaceRegular,
            _buildTicketClassificationDropdown(),
            UIHelpers.horizontalSpaceRegular,
            _buildValidationDropdown(),
            UIHelpers.horizontalSpaceRegular,
            _buildApplyFilterButton(),
            UIHelpers.horizontalSpaceRegular,
            _buildClearFilterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPipelineDropdown(List<Datums> items) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 420),
      child: TicketClassificationPipelineWidget(
        hintText: "Pipeline",
        items: items,
        selectedItem: selectedPipeline,
        onChanged: (selectedName) async {
          setState(() {
            selectedPipeline = selectedName;
          });

          await _savePipelineToLocalStorage(selectedName);

          _onPipelineSelectionChanged([selectedName], items);
        },
      ),
    );
  }

  void _onPipelineSelectionChanged(
      List<String> selectedNames, List<Datums> items) async {
    pipelineIds = [];
    for (var selectedName in selectedNames) {
      final matchingItem = items.firstWhere(
        (item) => item.pipelineName == selectedName,
        orElse: () => Datums(pipelineName: '', pipelineId: ''),
      );
      if (matchingItem.pipelineId?.isNotEmpty == true) {
        pipelineIds.add(matchingItem.pipelineId ?? "");
      }
    }

    // Save pipelineIds to local storage
    await LocalStorage.savePipelineIds(pipelineIds);
  }

  Future<void> _savePipelineToLocalStorage(String selectedName) async {
    try {
      await LocalStorage.savePipeline(selectedName);
    } catch (e) {
      debugPrint('Error saving to local storage: $e');
    }
  }

  Widget _buildDateRangeSelector() {
    if (selectedDatesNotifier.value == null) {
      final endDate = DateTime.now();
      final startDate = endDate.subtract(const Duration(days: 7));
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
            startDate = endDate.subtract(const Duration(days: 7));
          }

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
                  '${DateFormat('MMM dd').format(startDate)} - ${DateFormat('MMM dd yyyy').format(endDate)}',
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

  Widget _BopsState() {
    return SizedBox(
      width: 200,
      child: BlocBuilder<BopsStatesBloc, BopsStatesState>(
        builder: (context, state) {
          if (state is BopsStatesIntialState) {
            return const LoadingWidget(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              height: 40,
              width: 130,
            );
          }
          if (state is BopsStatesSucssesState) {
            return CustomMonthDropdown(
              items: state.model?.data ?? [],
              label: "BOps State",
              onChanged: (value) async {
                setState(() {
                  bopsState = value ?? '';
                });
                await _saveBopsStateLocalStorage(value);
              },
              selectedValue: bopsState,
            );
          }
          if (state is BopsStatesFailureState) {
            return const SizedBox(child: Text("Data Not Available"));
          }
          return const SizedBox(width: 200);
        },
      ),
    );
  }

  Future<void> _saveBopsStateLocalStorage(String? value) async {
    try {
      await LocalStorage.saveBopsState(value);
    } catch (e) {
      print('Error saving to local storage: $e');
    }
  }

  Widget _buildTicketClassificationDropdown() {
    return SizedBox(
      width: 230,
      child: CustomMonthDropdown(
        label: "Classification",
        selectedValue: selectedValue,
        onChanged: (value) async {
          setState(() {
            selectedValue = value ?? "";
          });
          await LocalStorage.saveClassification(value);
        },
        items: const [
          "All",
          "Spam/Marketing",
          "No Action Required",
          "Genuine Query",
          "Acknowledgement Required",
        ],
      ),
    );
  }

  Widget _buildValidationDropdown() {
    return SizedBox(
      width: 200,
      child: CustomMonthDropdown(
        label: "Validation",
        selectedValue: validation,
        onChanged: (value) async {
          setState(() {
            validation = value ?? "";
          });
          await LocalStorage.saveValidation(value);
        },
        items: const ["not validated", "correct", "incorrect"],
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

  void _addEvents() {
    final selectedItemValue = pipelineIds.isEmpty ? ["11257490"] : pipelineIds;
    DateTime startDate;
    DateTime endDate;

    if (selectedItemValue.isEmpty) {
      showSnackbar(
        context,
        'Please select a pipeline to apply filter',
      );
      return;
    }

    endDate = DateTime.now();
    startDate = endDate.subtract(const Duration(days: 7));

    if (selectedItem.isNotEmpty) {
      BlocProvider.of<TicketClassificationTabBloc>(context)
          .add(TicketClassificationDataCallEvent(
        fieldValue: pipelineIds,
        startDate: startDate,
        endDate: endDate,
        page: 1,
        pageSize: 10,
      ));
    }
  }

  Widget _buildClearFilterButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        setState(() {
          selectedItem = '';
          selectedValue = '';
          bopsState = '';
          validation = '';
          selectedDatesNotifier.value = null;
          pipelineIds.clear();
        });

        await LocalStorage.clearPipeline();
        await LocalStorage.clearClassification();
        await LocalStorage.clearBopsState();
        await LocalStorage.clearValidation();
        await LocalStorage.clearSelectedDates();
      },
      icon: const Icon(Icons.clear_all, color: Colors.white),
      label: const Text('Clear Filters', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
        backgroundColor: Colors.redAccent, // You can choose another color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  Future<void> _pickDateRange() async {
    final DateTime endDate = DateTime.now();
    final DateTime startDate = endDate.subtract(const Duration(days: 7));

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
      final startDate = pickedDates.isNotEmpty ? pickedDates[0] : null;
      final endDate = pickedDates.length > 1 ? pickedDates[1] : null;

      await LocalStorage.saveSelectedDates(startDate, endDate);
    }
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
}

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/get_all_pipeline_bloc/get_all_pipeline_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/bops_states_bloc/bops_states_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/widgets/ticket_classification_pipeline_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_month_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/export_button_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';
import 'package:intl/intl.dart';

class TicketClassificationFiltersWidget extends StatefulWidget {
  TicketClassificationFiltersWidget({super.key});

  @override
  _HomeFiltersWidgetState createState() => _HomeFiltersWidgetState();
}

class _HomeFiltersWidgetState extends State<TicketClassificationFiltersWidget> {
  final s = serviceLocator<S>();
  final ValueNotifier<List<DateTime>?> selectedDatesNotifier =
      ValueNotifier<List<DateTime>?>(null);
  final ValueNotifier<bool> _isSearchOpen = ValueNotifier<bool>(false);
  final TextEditingController _searchController = TextEditingController();
  String selectedClassification = '';
  List<DateTime?> selectedate = [];
  String selectedBOPsState = '';
  String selectedItem = '';
  String selectedValidation = '';
  List<String> pipelineIds = [];
  String selectedPipeline = "";

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
            _bopsState(),
            UIHelpers.horizontalSpaceRegular,
            _buildTicketClassificationDropdown(),
            UIHelpers.horizontalSpaceRegular,
            _buildValidationDropdown(),
            UIHelpers.horizontalSpaceRegular,
            _buildApplyFilterButton(
              context,
            ),
            UIHelpers.horizontalSpaceRegular,
            _buildClearFilterButton(),
            UIHelpers.horizontalSpaceRegular,
            _buildSearchWidget(),
            _buildExportButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPipelineDropdown(List<Datums> items) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 220),
      child: TicketClassificationPipelineWidget(
        hintText:
            selectedPipeline.isEmpty ? s.intialpiplineText : selectedPipeline,
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

    await LocalStorage.savePipelineIds(pipelineIds);
  }

  Future<void> _savePipelineToLocalStorage(String selectedName) async {
    await LocalStorage.savePipeline(selectedName);
  }

  Widget _buildDateRangeSelector() {
    if (selectedate.isNotEmpty) {
      final endDate = selectedate.lastOrNull;
      final startDate = selectedate.firstOrNull;
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
            endDate = DateTime.now();
            startDate = endDate.subtract(const Duration(days: 0));
          }

          return Container(
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

  Widget _bopsState() {
    return SizedBox(
      child: BlocBuilder<BopsStatesBloc, BopsStatesState>(
        builder: (context, state) {
          if (state is BopsStatesSuccessState) {
            return CustomMonthDropdown(
              items: state.bOpsResponseAttributeModel?.data ?? [],
              label: selectedBOPsState.isEmpty
                  ? s.bobStateText
                  : selectedBOPsState,
              onChanged: (value) async {
                setState(() {
                  selectedBOPsState = value ?? '';
                });
              },
              selectedValue: selectedBOPsState,
            );
          }
          if (state is BopsStatesFailureState) {
            return const SizedBox(child: Text("Data Not Available"));
          }
          return CustomMonthDropdown(
            items: [],
            label: s.bobStateText,
            onChanged: (value) {},
            selectedValue: selectedBOPsState,
          );
        },
      ),
    );
  }

  Widget _buildTicketClassificationDropdown() {
    return SizedBox(
      child: CustomMonthDropdown(
        label: selectedClassification.isEmpty
            ? s.classification
            : selectedClassification,
        selectedValue: selectedClassification,
        onChanged: (value) async {
          setState(() {
            selectedClassification = value ?? "";
          });
        },
        items: const [
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
        label: selectedValidation.isEmpty ? s.validation : selectedValidation,
        selectedValue: selectedValidation,
        onChanged: (value) async {
          setState(() {
            selectedValidation = value?.toLowerCase() ?? "";
          });
        },
        items: const ["Not Validated", "Correct", "Incorrect"],
      ),
    );
  }

  Widget _buildApplyFilterButton(BuildContext context) {
    return Container(
      height: 180,
      child: ElevatedButton.icon(
        onPressed: () {
          final selectedPipelineValue =
              pipelineIds.isEmpty ? ["11257490"] : pipelineIds;

          if (selectedPipelineValue.isEmpty) {
            showSnackbar(
              context,
              s.filterApplySnackBarText,
            );
            return;
          }
          final bloc = BlocProvider.of<TicketClassificationTabBloc>(context);
          bloc.selectedPipelineId = selectedPipelineValue.first;
          bloc.selectedBOPsState = selectedBOPsState;
          bloc.selectedClassification = selectedClassification;
          bloc.selectedValidation = selectedValidation;
          bloc.add(TicketClassificationDataCallEvent(
            fieldValue: selectedPipelineValue,
            endDate: selectedate.lastOrNull,
            startDate: selectedate.firstOrNull,
            page: 1,
            pageSize: 10,
          ));
        },
        icon: const Icon(SupportBotIcons.filter, color: Colors.white),
        label: Text(
          s.filterApplyText,
          style: SupportBotTextstyle.hint.copyWith(
            color: SupportBotColors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: SupportBotColors.bluePrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return ValueListenableBuilder<bool>(
      valueListenable: _isSearchOpen,
      builder: (context, isSearchOpen, child) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(
                  isSearchOpen ? Icons.close : Icons.search,
                  size: 25,
                  color: Colors.black,
                ),
                onPressed: () {
                  if (isSearchOpen) {
                    if (_searchController.text.isNotEmpty) {
                      _searchController.clear();
                      final selectedPipelineValue =
                          pipelineIds.isEmpty ? ["11257490"] : pipelineIds;
                      BlocProvider.of<TicketClassificationTabBloc>(context).add(
                        TicketClassificationDataCallEvent(
                          fieldValue: selectedPipelineValue,
                          endDate: selectedate.lastOrNull,
                          startDate: selectedate.firstOrNull,
                          ticketId: _searchController.text,
                          page: 1,
                          pageSize: 10,
                        ),
                      );
                    }
                  }
                  _isSearchOpen.value = !isSearchOpen;
                },
              ),
            ),
            if (isSearchOpen)
              SizedBox(
                width: UIHelpers.screenWidth(context) * 0.115,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: s.searchText,
                    hintStyle: SupportBotTextstyle.medium.copyWith(
                      color: SupportBotColors.gray.shade600,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: SupportBotColors.bluePrimary.shade500,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: SupportBotColors.bluePrimary.shade500,
                      ),
                    ),
                    isDense: true,
                  ),
                  onSubmitted: (value) {
                    final selectedPipelineValue =
                        pipelineIds.isEmpty ? ["11257490"] : pipelineIds;
                    BlocProvider.of<TicketClassificationTabBloc>(context).add(
                      TicketClassificationDataCallEvent(
                        fieldValue: selectedPipelineValue,
                        endDate: selectedate.lastOrNull,
                        startDate: selectedate.firstOrNull,
                        ticketId: _searchController.text,
                        page: 1,
                        pageSize: 10,
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildClearFilterButton() {
    return SizedBox(
      height: 180,
      child: ElevatedButton.icon(
        onPressed: () async {
          setState(() {
            selectedItem = '';
            selectedClassification = '';
            selectedBOPsState = '';
            selectedValidation = '';
            selectedDatesNotifier.value = null;
            pipelineIds.clear();
            selectedPipeline = "";
          });
          BlocProvider.of<TicketClassificationTabBloc>(context).clearFilters();
          BlocProvider.of<TicketClassificationTabBloc>(context)
              .add(TicketClassificationDataCallEvent(
            selectedBOPsState: selectedBOPsState,
            selectedClassification: selectedClassification,
            selectedValidation: selectedValidation,
            fieldValue: ['11257490'],
            endDate: DateTime.now()
                ?.copyWith(hour: 23, minute: 59, second: 59, millisecond: 999),
            startDate: DateTime.now()
                ?.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0),
            page: 1,
            pageSize: 10,
          ));
        },
        icon: const Icon(Icons.clear_all, color: Colors.white),
        label: Text(
          s.filterClearText,
          style: SupportBotTextstyle.hint.copyWith(
            color: SupportBotColors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.redAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  Future<void> _pickDateRange() async {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
      dayTextStyle: SupportBotTextstyle.mediumHint.copyWith(
        color: SupportBotColors.black,
        fontWeight: FontWeight.w700,
      ),
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: SupportBotColors.bluePrimary,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: SupportBotTextstyle.mediumHint.copyWith(
        color: SupportBotColors.black,
        fontWeight: FontWeight.bold,
      ),
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

  Widget _buildExportButton() {
    String getPipelineId() {
      if (pipelineIds.isNotEmpty && selectedPipeline.isNotEmpty) {
        return pipelineIds.first ?? "11257490";
      }
      return '11257490';
    }

    return Tooltip(
      message: 'Export CSV File',
      child: ExportButton(
          icon: 'assets/icons/Export.svg',
          selectedButtonText: s.ticketClassification,
          startDate: selectedDatesNotifier.value?.first ?? DateTime.now(),
          endDate: selectedDatesNotifier.value?.last ?? DateTime.now(),
          bopsState: selectedBOPsState,
          selectedClassification: selectedClassification,
          selectedClassificationValidation: selectedValidation,
          selectedPipeline: getPipelineId()),
    );
  }
}

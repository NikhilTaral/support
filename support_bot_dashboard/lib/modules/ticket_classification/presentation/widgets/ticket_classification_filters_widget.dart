import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/get_all_pipeline_bloc/get_all_pipeline_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/bops_states_bloc/bops_states_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/get_all_validatod_user_bloc/get_all_validation_user_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/widgets/ticket_classification_pipeline_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_month_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/export_button_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';
import 'package:intl/intl.dart';

class TicketClassificationFiltersWidget extends StatefulWidget {
  const TicketClassificationFiltersWidget(
      {super.key,
      this.endDate,
      this.pipelineName,
      this.piplineId,
      this.startDate});
  final String? pipelineName;
  final String? piplineId;
  final DateTime? startDate;
  final DateTime? endDate;
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
  String selectedUserValidator = "";
  String selectedItem = '';
  String selectedUserName = "";
  String selectedValidation = '';
  String pipelineIds = "";
  String setvalue = "";
  String selectedPipeline = "";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BopsStatesBloc()..add(BopsStateDataEvent()),
        ),
        BlocProvider(
          create: (context) => GetAllValidationUsersBloc()
            ..add(GetValidationUsersInitialEvent(
                endDate: widget.endDate ?? DateTime.now(),
                filter: [widget.piplineId ?? ""],
                startDate: widget.startDate ?? DateTime.now())),
        ),
      ],
      child: BlocBuilder<GetAllPipelineBloc, GetAllPipelineState>(
        builder: (context, state) {
          if (state is GetAllAllPipelineSuccessState) {
            List<GetAllPipelineData> items = state.attributeModel?.data ?? [];
            return _buildFiltersRow(items);
          } else if (state is GetAllPipelineLoadingState) {
            return _buildLoadingState();
          } else if (state is GetAllPipelineFailureState) {
            return const Center(child: Text("No data Found"));
          }
          return const Center(child: EmptyWidget());
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

  Widget _buildFiltersRow(List<GetAllPipelineData> items) {
    return SizedBox(
      height: 40,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            _getAllValidatedUser(),
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

  Widget _buildPipelineDropdown(List<GetAllPipelineData> items) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 220),
      child: TicketClassificationPipelineWidget(
        hintText: selectedPipeline.isEmpty
            ? (widget.pipelineName ?? '')
            : selectedPipeline,
        items: items,
        selectedItem: selectedPipeline,
        onChanged: (selectedName) async {
          setState(() {
            if (widget.pipelineName != null) {
              selectedPipeline = (widget.pipelineName ?? "");
            }
            selectedPipeline = selectedName;
          });

          _onPipelineSelectionChanged([selectedName], items);
        },
      ),
    );
  }

  void _onPipelineSelectionChanged(
      List<String> selectedNames, List<GetAllPipelineData> items) async {
    pipelineIds = '';
    for (var selectedName in selectedNames) {
      final matchingItem = items.firstWhere(
        (item) => item.pipelineName == selectedName,
        orElse: () => GetAllPipelineData(pipelineName: '', pipelineId: ''),
      );
      if (matchingItem.pipelineId?.isNotEmpty == true) {
        pipelineIds = (matchingItem.pipelineId ?? "");
      }
    }
  }

  Widget _buildDateRangeSelector() {
    if (selectedate.isNotEmpty) {
      final endDate = selectedate.lastOrNull ?? widget.endDate;
      final startDate = selectedate.firstOrNull ?? widget.startDate;
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
          print("BopsStatesBloc State ${state}");
          if (state is BopsStatesSuccessState) {
            return CustomDropdown(
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
            return const SizedBox(child: EmptyWidget());
          }
          if (state is BopsStatesEmptyState) {
            return CustomDropdown(
              items: s.noStateAvailableText.split(","),
              label: s.bobStateText,
              onChanged: (value) async {},
              selectedValue: selectedBOPsState,
            );
          }
          return CustomDropdown(
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
      child: CustomDropdown(
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
      child: CustomDropdown(
        label: selectedValidation.isEmpty ? s.validation : selectedValidation,
        selectedValue: setvalue,
        onChanged: (value) async {
          setState(() {
            setvalue = value ?? "";
            selectedValidation = value?.toLowerCase() ?? "";
          });
        },
        items: const ["Not Validated", "Correct", "Incorrect"],
      ),
    );
  }

  Widget _getAllValidatedUser() {
    return SizedBox(
      child: BlocBuilder<GetAllValidationUsersBloc, GetAllValidationUsersState>(
        builder: (context, state) {
          if (state is GetAllValidationUsersSuccessState) {
            var users = state.getAllValidationUsersAttributeModel?.data ?? [];

            return CustomDropdown(
              items: users.map((e) => e.name ?? "").toSet().toList(),
              label: selectedUserName.isEmpty
                  ? s.validatedUserText
                  : users
                          .firstWhere(
                            (element) => element.name == selectedUserValidator,
                            orElse: () => users.first,
                          )
                          .name ??
                      s.validatedUserText,
              onChanged: (value) {
                var selectedUser = users.firstWhere(
                  (element) => element.name == value,
                  orElse: () => users.first,
                );

                BlocProvider.of<GetAllValidationUsersBloc>(context).add(
                  SetUserNameEvent(
                    email: selectedUser.email,
                    name: selectedUser.name,
                  ),
                );

                setState(() {
                  selectedUserValidator = selectedUser.email ?? '';
                  selectedUserName = selectedUser.name ?? "";
                });
              },
              selectedValue: selectedUserName,
            );
          }
          if (state is GetAllValidationUsersEmptyState) {
            return CustomDropdown(
              items: s.noUserAvailableText.split(","),
              label: s.validatedUserText,
              selectedValue: '',
              onChanged: (String? value) {},
            );
          }
          if (state is GetAllValidationUsersFailureState) {
            return SizedBox(child: Text(s.noDataFoundText));
          }
          return CustomDropdown(
            items: [],
            label: s.validatedUserText,
            onChanged: (value) {
              setState(() {
                selectedUserName = value ?? "";
              });
            },
            selectedValue: selectedUserName,
          );
        },
      ),
    );
  }

  Widget _buildApplyFilterButton(BuildContext context) {
    return BlocBuilder<GetAllValidationUsersBloc, GetAllValidationUsersState>(
      builder: (context, state) {
        return SizedBox(
          height: 180,
          child: ElevatedButton.icon(
            onPressed: () {
              final selectedPipelineValue =
                  pipelineIds.isEmpty ? widget.piplineId : pipelineIds;
              if (selectedPipelineValue == null) {
                showSnackbar(
                  context,
                  s.filterApplySnackBarText,
                );
                return;
              }
              BlocProvider.of<GetAllValidationUsersBloc>(context)
                  .add(GetValidationUsersInitialEvent(
                endDate: selectedate.lastOrNull ?? widget.endDate,
                startDate: selectedate.firstOrNull ?? widget.startDate,
                filter: [selectedPipelineValue ?? ""],
              ));

              final bloc =
                  BlocProvider.of<TicketClassificationTabBloc>(context);
              bloc.selectedPipelineId = selectedPipelineValue;
              bloc.selectedUserValidator = selectedUserValidator;
              bloc.selectedBOPsState = selectedBOPsState;
              bloc.selectedClassification = selectedClassification;
              bloc.selectedValidation = selectedValidation;
              bloc.add(TicketClassificationDataCallEvent(
                fieldValue: selectedPipelineValue,
                endDate: selectedate.lastOrNull ?? widget.endDate,
                startDate: selectedate.firstOrNull ?? widget.startDate,
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        );
      },
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
                  isSearchOpen ? SupportBotIcons.close : SupportBotIcons.search,
                  size: 25,
                  color: SupportBotColors.bluePrimary,
                ),
                onPressed: () {
                  if (isSearchOpen) {
                    if (_searchController.text.isNotEmpty) {
                      _searchController.clear();
                      final selectedPipelineValue =
                          pipelineIds.isEmpty ? "11257490" : pipelineIds;
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
                        pipelineIds.isEmpty ? "11257490" : pipelineIds;
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
    return BlocBuilder<GetAllValidationUsersBloc, GetAllValidationUsersState>(
      builder: (context, state) {
        return SizedBox(
          height: 180,
          child: ElevatedButton.icon(
            onPressed: () async {
              setState(() {
                setvalue = "";
                selectedUserValidator = '';
                selectedUserName = '';
                selectedItem = '';
                selectedClassification = '';
                selectedBOPsState = '';
                selectedValidation = '';
                selectedDatesNotifier.value = null;
                pipelineIds = "";
                selectedPipeline = "";
                selectedate = [];
              });

              BlocProvider.of<TicketClassificationTabBloc>(context)
                  .clearFilters();
              BlocProvider.of<TicketClassificationTabBloc>(context).add(
                TicketClassificationDataCallEvent(
                  selectedBOPsState: selectedBOPsState,
                  selectedClassification: selectedClassification,
                  selectedValidation: selectedValidation,
                  fieldValue: widget.piplineId,
                  endDate: widget.endDate,
                  startDate: widget.startDate,
                  page: 1,
                  pageSize: 10,
                ),
              );
              BlocProvider.of<GetAllValidationUsersBloc>(context)
                  .add(GetValidationUsersInitialEvent(
                endDate: selectedate.lastOrNull ?? widget.endDate,
                startDate: selectedate.firstOrNull ?? widget.startDate,
                filter: [widget.piplineId ?? ""],
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        );
      },
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
      if (pipelineIds.isEmpty) {
        return widget.piplineId ?? "";
      }
      return pipelineIds;
    }

    return BlocBuilder<GetAllValidationUsersBloc, GetAllValidationUsersState>(
      builder: (context, state) {
        return Tooltip(
          message: s.exportCSVFileText,
          child: ExportButton(
              icon: '',
              selectedButtonText: s.ticketClassification,
              startDate: selectedate.firstOrNull ?? widget.startDate,
              endDate: selectedate.lastOrNull ?? widget.endDate,
              bopsState: selectedBOPsState,
              selectedClassification: selectedClassification,
              selectedClassificationValidation: selectedValidation,
              selectedPipeline: getPipelineId()),
        );
      },
    );
  }
}

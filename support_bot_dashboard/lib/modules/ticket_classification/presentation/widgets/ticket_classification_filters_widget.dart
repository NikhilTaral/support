import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/get_all_pipeline_bloc/get_all_pipeline_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/bops_states_bloc/bops_states_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/get_all_validatod_user_bloc/get_all_validation_user_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/widgets/ticket_classification_pipeline_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_search_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_month_dropdown.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => FilterBloc(
                startDate: widget.startDate,
                endDate: widget.endDate,
                defualtPipeline: widget.pipelineName ?? "",
                defualtPipelineId: widget.piplineId ?? "")
              ..add(FilterInitialEvent())),
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
            return Center(child: Text(s.noDataFoundText));
          }
          return Center(child: Text(s.noDataFoundText));
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
          spacing: 15,
          children: [
            _buildPipelineDropdown(items),
            _buildDateRangeSelector(context),
            _bopsState(),
            _buildTicketClassificationDropdown(),
            _buildValidationDropdown(),
            _getAllValidatedUser(),
            _buildApplyFilterButton(
              context,
            ),
            _buildClearFilterButton(),
            _buildSearchWidget(),
            _buildExportButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPipelineDropdown(List<GetAllPipelineData> items) {
    return BlocSelector<FilterBloc, FilterState, String>(
      selector: (state) {
        if (state is FilterSuccessState) {
          return state.piplineName ?? "";
        }
        return '';
      },
      builder: (context, selectedPipeline) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 220),
          child: TicketClassificationPipelineWidget(
            hintText: selectedPipeline,
            items: items,
            selectedItem: selectedPipeline,
            onChanged: (piplineName) async {
              String pipelineIds = '';
              for (var selectedName in [piplineName]) {
                final matchingItem = items.firstWhere(
                  (item) => item.pipelineName == selectedName,
                  orElse: () =>
                      GetAllPipelineData(pipelineName: '', pipelineId: ''),
                );
                if (matchingItem.pipelineId?.isNotEmpty == true) {
                  pipelineIds = matchingItem.pipelineId ?? "";
                }
              }

              BlocProvider.of<FilterBloc>(context).add(
                SelcetPiplineEvent(
                  piplineName: piplineName,
                  pipelineId: pipelineIds,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDateRangeSelector(BuildContext context) {
    return Center(
      child: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {
          DateTime startDate;
          DateTime endDate;
          if (state is FilterSuccessState) {
            startDate = state.startDate ?? widget.startDate ?? DateTime.now();
            endDate = state.endDate ?? widget.endDate ?? DateTime.now();
          } else {
            startDate = widget.startDate ?? DateTime.now();
            endDate = widget.endDate ?? DateTime.now();
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
              onPressed: () => _pickDateRange(context),
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

  Future<void> _pickDateRange(BuildContext context) async {
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
      BlocProvider.of<FilterBloc>(context).add(
        SelecrtDateRangeEvent(
          startDate: pickedDates.first,
          endDate:
              pickedDates.length > 1 ? pickedDates.last : pickedDates.first,
        ),
      );
    }
  }

  Widget _bopsState() {
    return SizedBox(
      child: BlocBuilder<BopsStatesBloc, BopsStatesState>(
        builder: (context, state1) {
          if (state1 is BopsStatesSuccessState) {
            return BlocSelector<FilterBloc, FilterState, String>(
              selector: (state) {
                if (state is FilterSuccessState) {
                  return state.bopsState ?? "";
                }
                return "";
              },
              builder: (context, filterState) {
                return CustomSearchDropdown(
                  items: state1.bOpsResponseAttributeModel?.data ?? [],
                  label: filterState.isEmpty ? s.bobStateText : filterState,
                  onChanged: (value) {
                    BlocProvider.of<FilterBloc>(context).add(
                      SelectBopsStateEvent(
                        bopsState: value,
                      ),
                    );
                  },
                  selectedValue: filterState,
                );
              },
            );
          }

          if (state1 is BopsStatesFailureState) {
            return const SizedBox(child: Text("Data Not Available"));
          }

          if (state1 is BopsStatesEmptyState) {
            return CustomDropdown(
                items: const ["No State Available"],
                label: s.bobStateText,
                onChanged: (value) {},
                selectedValue: "");
          }

          return CustomDropdown(
            items: const [],
            label: s.bobStateText,
            onChanged: (value) {},
            selectedValue: "",
          );
        },
      ),
    );
  }

  Widget _buildTicketClassificationDropdown() {
    return BlocSelector<FilterBloc, FilterState, String>(
      selector: (state) {
        if (state is FilterSuccessState) {
          return state.aiClassification ?? "";
        }
        return "";
      },
      builder: (context, state) {
        return SizedBox(
          child: CustomDropdown(
            label: state.isEmpty ? s.classification : state,
            selectedValue: state,
            onChanged: (value) async {
              BlocProvider.of<FilterBloc>(context).add(
                AIClassificationEvent(
                  aiClassification: value,
                ),
              );
            },
            items: const [
              "Spam/Marketing",
              "No Action Required",
              "Genuine Query",
              "Acknowledgement Required",
              "Not Classified",
            ],
          ),
        );
      },
    );
  }

  Widget _buildValidationDropdown() {
    return BlocSelector<FilterBloc, FilterState, String>(
      selector: (state) {
        if (state is FilterSuccessState) {
          return state.validation ?? "";
        }
        return "";
      },
      builder: (context, state) {
        return SizedBox(
          width: 200,
          child: CustomDropdown(
            label: state.isEmpty ? s.validation : state,
            selectedValue: state,
            onChanged: (value) async {
              BlocProvider.of<FilterBloc>(context).add(
                ValidationEvent(
                  validation: value,
                ),
              );
            },
            items: const ["Not Validated", "Correct", "Incorrect"],
          ),
        );
      },
    );
  }

  Widget _getAllValidatedUser() {
    return SizedBox(
      child: BlocBuilder<GetAllValidationUsersBloc, GetAllValidationUsersState>(
        builder: (context, state) {
          final userName = BlocProvider.of<FilterBloc>(context).userName;
          if (state is GetAllValidationUsersSuccessState) {
            var users = state.getAllValidationUsersAttributeModel?.data ?? [];

            return BlocSelector<FilterBloc, FilterState, String>(
              selector: (state) {
                if (state is FilterSuccessState) {
                  return state.selectedUserName ?? "";
                }
                return "";
              },
              builder: (context, state) {
                return CustomSearchDropdown(
                    items: users.map((e) => e.name ?? "").toSet().toList(),
                    label: state.isEmpty
                        ? s.validatedUserText
                        : users
                                .firstWhere(
                                  (element) => element.name == state,
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

                      BlocProvider.of<FilterBloc>(context).add(
                        UserValidationEvent(
                          selectedUserName: selectedUser.name ?? "",
                          selectedUserEmail: selectedUser.email ?? "",
                        ),
                      );
                    },
                    selectedValue: state);
              },
            );
          }
          if (state is GetAllValidationUsersLoadingState) {
            return CustomDropdown(
              items: "No User Available".split(","),
              label:
                  (userName?.isEmpty ?? true) ? s.validatedUserText : userName!,
              selectedValue: '',
              onChanged: (String? value) {},
            );
          }
          if (state is GetAllValidationUsersEmptyState) {
            return CustomDropdown(
              items: "No User Available".split(","),
              label: s.validatedUserText,
              selectedValue: '',
              onChanged: (String? value) {},
            );
          }
          if (state is GetAllValidationUsersFailureState) {
            return SizedBox(child: Text(s.noDataFoundText));
          }
          return CustomDropdown(
            items: const [],
            label: userName ?? "",
            onChanged: (value) {},
            selectedValue: "",
          );
        },
      ),
    );
  }

  Widget _buildApplyFilterButton(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, filterState) {
        return BlocBuilder<GetAllValidationUsersBloc,
            GetAllValidationUsersState>(
          builder: (context, state) {
            return SizedBox(
              height: 180,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (filterState is! FilterSuccessState) {
                    showSnackbar(context, s.filterApplySnackBarText);
                    return;
                  }
                  String? selectedPipelineValue =
                      filterState.piplineId ?? widget.piplineId;
                  if (selectedPipelineValue == null) {
                    showSnackbar(context, s.filterApplySnackBarText);
                    return;
                  }

                  BlocProvider.of<GetAllValidationUsersBloc>(context).add(
                    GetValidationUsersInitialEvent(
                      endDate: filterState.endDate ?? widget.endDate,
                      startDate: filterState.startDate ?? widget.startDate,
                      filter: [selectedPipelineValue],
                    ),
                  );

                  final classificationBloc =
                      BlocProvider.of<TicketClassificationTabBloc>(context);

                  classificationBloc.selectedUserValidator =
                      filterState.selectedUserId ?? "";
                  classificationBloc.selectedBOPsState =
                      filterState.bopsState ?? "";
                  classificationBloc.selectedClassification =
                      filterState.aiClassification ?? "";
                  classificationBloc.selectedValidation =
                      filterState.validation?.toLowerCase() ?? "";

                  classificationBloc.add(TicketClassificationDataCallEvent(
                    fieldValue: filterState.piplineId ?? widget.piplineId,
                    endDate: filterState.endDate ?? widget.endDate,
                    startDate: filterState.startDate ?? widget.startDate,
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
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSearchWidget() {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, filterstate) {
        if (filterstate is FilterSuccessState) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                  icon: Icon(
                    filterstate.isSearchOpen == false
                        ? SupportBotIcons.close
                        : SupportBotIcons.search,
                    size: 25,
                    color: SupportBotColors.bluePrimary,
                  ),
                  onPressed: () {
                    BlocProvider.of<FilterBloc>(context).add(
                      ToggleSearchEvent(
                          isSearchOpen: !(filterstate.isSearchOpen ?? false),
                          searchText: ""),
                    );
                    if (filterstate.isSearchOpen == true) {
                      if (filterstate.searchController!.isNotEmpty) {
                        filterstate.searchController == "";
                        final selectedPipelineValue = filterstate.piplineId;
                        BlocProvider.of<TicketClassificationTabBloc>(context)
                            .add(
                          TicketClassificationDataCallEvent(
                            fieldValue: selectedPipelineValue,
                            endDate: filterstate.endDate ?? widget.endDate,
                            startDate:
                                filterstate.startDate ?? widget.startDate,
                            ticketId: filterstate.searchController,
                            page: 1,
                            pageSize: 10,
                          ),
                        );
                      }
                    }
                    filterstate.isSearchOpen == true;
                  },
                ),
              ),
              if (filterstate.isSearchOpen == false)
                SizedBox(
                  width: UIHelpers.screenWidth(context) * 0.115,
                  child: TextField(
                    controller: TextEditingController(
                        text: filterstate.searchController),
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
                      BlocProvider.of<FilterBloc>(context).add(
                        ToggleSearchEvent(
                            value: value,
                            isSearchOpen: !(filterstate.isSearchOpen ?? false),
                            searchText: value),
                      );
                      final selectedPipelineValue =
                          filterstate.piplineId!.isEmpty
                              ? widget.piplineId
                              : filterstate.piplineId;
                      BlocProvider.of<TicketClassificationTabBloc>(context).add(
                        TicketClassificationDataCallEvent(
                          fieldValue: selectedPipelineValue,
                          endDate: filterstate.endDate ?? widget.endDate,
                          startDate: filterstate.startDate ?? widget.startDate,
                          ticketId: value,
                          page: 1,
                          pageSize: 10,
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildClearFilterButton() {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, filterState) {
        if (filterState is FilterSuccessState) {
          return BlocBuilder<GetAllValidationUsersBloc,
              GetAllValidationUsersState>(
            builder: (context, state) {
              return SizedBox(
                height: 180,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    BlocProvider.of<FilterBloc>(context).add(
                      ClearFilterEvent(),
                    );
                    BlocProvider.of<TicketClassificationTabBloc>(context)
                        .clearFilters();
                    BlocProvider.of<TicketClassificationTabBloc>(context).add(
                      TicketClassificationDataCallEvent(
                        selectedBOPsState: filterState.bopsState,
                        selectedClassification: filterState.aiClassification,
                        selectedValidation: filterState.validation,
                        fieldValue: widget.piplineId,
                        endDate: widget.endDate,
                        startDate: widget.startDate,
                        page: 1,
                        pageSize: 10,
                      ),
                    );
                    BlocProvider.of<GetAllValidationUsersBloc>(context)
                        .add(GetValidationUsersInitialEvent(
                      endDate: widget.endDate,
                      startDate: widget.startDate,
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
        return Container();
      },
    );
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
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state1) {
        if (state1 is FilterSuccessState) {
          return Tooltip(
            message: s.export,
            child: ExportButton(
                exportUser: state1.selectedUserId ?? "",
                ticketId: state1.searchController,
                icon: '',
                startDate: state1.startDate ?? widget.startDate,
                selectedButtonText: s.ticketClassification,
                endDate: state1.endDate ?? widget.endDate,
                bopsState: state1.bopsState,
                selectedClassification: state1.aiClassification,
                selectedClassificationValidation:
                    state1.validation?.toLowerCase(),
                selectedPipeline: state1.piplineId ?? widget.piplineId),
          );
        }
        return Container();
      },
    );
  }
}

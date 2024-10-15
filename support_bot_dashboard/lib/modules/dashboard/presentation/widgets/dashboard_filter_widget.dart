import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/config/environment/env_config.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_answer/ai_query_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_chart_bloc/ai_query_chart_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/custom_button_bloc/custombutton_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_date_selection_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_button.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_filter_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_month_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/export_button.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

enum FilterChangeType {
  date,
  month,
  classification,
  validation,
  AIclassification
}

class DashboardFilterWidget extends StatelessWidget {
  String pipeline;
  DateTime? selectedDate;
  DateTime? selectedMonth;
  String? selectedClassification;
  String selectedClassificationValidation;
  final Function(FilterChangeType changeType, dynamic newValue) onFilterChanged;
  final ValueNotifier<int> currentPage;
  final ValueNotifier<int> pageSize;
  final ValueNotifier<int> AIcurrentPage;
  final ValueNotifier<int> AIpageSize;
  bool? isAnswer;

  DashboardFilterWidget(
      {super.key,
      required this.pipeline,
      required this.selectedClassification,
      required this.selectedDate,
      required this.selectedClassificationValidation,
      this.selectedMonth,
      required this.onFilterChanged,
      required this.isAnswer,
      required this.currentPage,
      required this.pageSize,
      required this.AIcurrentPage,
      required this.AIpageSize});

  final ValueNotifier<bool> _isSearchOpen = ValueNotifier<bool>(false);
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustombuttonBloc, CustombuttonState>(
      builder: (context, state) {
        String selectedButtonText = '';
        if (state is ButtonSelectedState) {
          selectedButtonText = state.selectedButtonText;
        }
        if (state is CustomButtonInitial &&
            state.selectedButtonText == 'Ticket Classification') {
          selectedButtonText = state.selectedButtonText;
        }

        return Column(
          children: [
            Row(
              children: [
                CustomButton(
                  text: S.of(context).ticketClassification,
                  isSelected: selectedButtonText == 'Ticket Classification',
                  onPressed: () {
                    BlocProvider.of<CustombuttonBloc>(context)
                        .add(SelectButtonEvent('Ticket Classification'));
                  },
                ),
                CustomButton(
                  text: S.of(context).aiQueryAnswer,
                  isSelected: selectedButtonText == 'AI Query Answer',
                  onPressed: () {
                    BlocProvider.of<CustombuttonBloc>(context)
                        .add(SelectButtonEvent('AI Query Answer'));
                  },
                ),
              ],
            ),
            // for Ticket Classification
            if (selectedButtonText == 'Ticket Classification')
              Row(
                children: [
                  // Date dropdown
                  BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      // String pipeline = '11257490';
                      if (state is DashboardDataSuccess) {
                        selectedDate = state.selectedDate;
                        pipeline = state.selectedPipeline;
                      }
                      return DateSelectionWidget(
                        selectedDate: selectedDate,
                        onChanged: (newDate) {
                          currentPage.value = 1;
                          pageSize.value = 10;
                          BlocProvider.of<DashboardBloc>(context)
                              .add(UpdateSelectedDateEvent(newDate, pipeline));
                          BlocProvider.of<PlutotableBloc>(context).add(
                              SelectDateEvent(
                                  selectedDate: newDate,
                                  selectedPipeline: pipeline,
                                  page: currentPage.value,
                                  pageSize: pageSize.value));
                          onFilterChanged(FilterChangeType.date, newDate);
                        },
                        label: S.of(context).day,
                        isInteractive: true,
                      );
                    },
                  ),
                  UIHelpers.horizontalSpaceSmall,

                  // Month dropdown
                  BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      String selectedMonthString = "January";
                      //   String pipeline = '11257490';

                      if (state is DashboardDataSuccess) {
                        selectedMonth = state.selectedMonth;
                        selectedMonthString =
                            _monthToString(selectedMonth!.month);
                        pipeline = state.selectedPipeline;
                      }
                      return CustomMonthDropdown(
                        selectedValue: selectedMonthString,
                        items: const [
                          'January',
                          'February',
                          'March',
                          'April',
                          'May',
                          'June',
                          'July',
                          'August',
                          'September',
                          'October',
                          'November',
                          'December'
                        ],
                        onChanged: (String? value) {
                          if (value != null) {
                            currentPage.value = 1;
                            pageSize.value = 10;
                            DateTime monthDateTime = _stringToMonth(value);
                            BlocProvider.of<DashboardBloc>(context).add(
                                UpdateSelectedMonthEvent(
                                    monthDateTime, pipeline));
                            BlocProvider.of<PlutotableBloc>(context).add(
                                SelectMonthEvent(
                                    selectedMonth: monthDateTime,
                                    selectedPipeline: pipeline,
                                    page: currentPage.value,
                                    pageSize: pageSize.value));

                            onFilterChanged(FilterChangeType.month, value);
                          }
                        },
                        label: S.of(context).month,
                      );
                    },
                  ),
                  UIHelpers.horizontalSpaceSmall,

                  // Classification dropdown
                  BlocBuilder<PlutotableBloc, PlutotableState>(
                    builder: (context, state) {
                      // String? pipeline = '11257490';
                      String? ticketId = '';
                      if (state is FetchTableDataSuccess) {
                        selectedDate = state.selectedDate;
                        selectedMonth = state.selectedMonth;
                        selectedClassification = state.selectedClassification;
                        pipeline = state.selectedPipeline;
                        ticketId = state.ticketId;
                      } else if (state is FetchTableDataError) {
                        selectedClassification = state.selectedClassification;
                      }

                      print(pipeline);
                      final classificationItems = [
                        'All',
                        'Spam/Marketing',
                        'No Action Required',
                        'Genuine Query',
                        'Acknowledgement Required'
                      ];
                      return CustomFilterDropdown(
                        selectedValue: selectedClassification ?? "",
                        items: classificationItems,
                        onChanged: (String? value) {
                          if (value != null) {
                            currentPage.value = 1;
                            pageSize.value = 10;
                            BlocProvider.of<PlutotableBloc>(context,
                                    listen: false)
                                .add(FilterClassificationEvent(
                                    selectedDate ?? null,
                                    selectedMonth,
                                    value,
                                    null,
                                    pipeline,
                                    ticketId,
                                    currentPage.value,
                                    pageSize.value));
                            onFilterChanged(
                                FilterChangeType.classification, value);
                          }
                        },
                        label: S.of(context).classification,
                        width: UIHelpers.screenWidth(context) * 0.15,
                        height: UIHelpers.screenHeight(context) * 0.05,
                      );
                    },
                  ),
                  UIHelpers.horizontalSpaceSmall,

                  // Validation dropdown
                  BlocBuilder<PlutotableBloc, PlutotableState>(
                    builder: (context, state) {
                      // String selectedValidation = '';
                      // String? pipeline = '11257490';
                      String? ticketId = '';
                      if (state is FetchTableDataSuccess) {
                        selectedDate = state.selectedDate ?? null;
                        selectedMonth = state.selectedMonth;
                        selectedClassification = state.selectedClassification;
                        selectedClassificationValidation =
                            state.selectedValidation ?? '';
                      } else if (state is FetchTableDataError) {
                        selectedClassification = state.selectedClassification;
                        selectedClassificationValidation =
                            state.selectedValidation ?? "";
                      }
                      final validationItems = [
                        'Not Updated',
                        'All',
                        'Correct',
                        'Incorrect'
                      ];
                      return CustomFilterDropdown(
                        selectedValue: selectedClassificationValidation ==
                                'correct'
                            ? 'Correct'
                            : selectedClassificationValidation == 'incorrect'
                                ? 'Incorrect'
                                : selectedClassificationValidation == 'all'
                                    ? 'All'
                                    : selectedClassificationValidation ==
                                            'not updated'
                                        ? 'Not Updated'
                                        : selectedClassificationValidation,
                        items: validationItems,
                        onChanged: (String? value) {
                          if (value != null) {
                            currentPage.value = 1;
                            pageSize.value = 10;
                            String lowercaseValue = value.toLowerCase();
                            BlocProvider.of<PlutotableBloc>(context,
                                    listen: false)
                                .add(FilterValidationEvent(
                                    lowercaseValue,
                                    selectedDate ?? null,
                                    selectedMonth,
                                    selectedClassification ?? "",
                                    pipeline,
                                    ticketId,
                                    currentPage.value,
                                    pageSize.value));
                            onFilterChanged(FilterChangeType.validation, value);
                          }
                        },
                        label: S.of(context).validation,
                        width: UIHelpers.screenWidth(context) * 0.14,
                        height: UIHelpers.screenHeight(context) * 0.05,
                      );
                    },
                  ),
                  const Spacer(),
                  BlocBuilder<PlutotableBloc, PlutotableState>(
                    builder: (context, state) {
                      if (state is FetchTableDataSuccess) {
                        selectedDate = state.selectedDate;
                        selectedMonth = state.selectedMonth;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _isSearchOpen,
                          builder: (context, isOpen, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height:
                                      UIHelpers.screenHeight(context) * 0.05,
                                      // width: UIHelpers.screenWidth(context) * 0.15,
                                  decoration: isOpen
                                      ? BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: SupportBotColors.gray),
                                        )
                                      : null,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: IconButton(
                                          icon: Icon(
                                            isOpen ? Icons.close : Icons.search,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            if (isOpen) {
                                              BlocProvider.of<PlutotableBloc>(
                                                      context)
                                                  .add(FetchTableDataEvent(
                                                      selectedDate:
                                                          selectedDate,
                                                      selectedMonth:
                                                          selectedMonth,
                                                      selectedClassification:
                                                          selectedClassification,
                                                      selectedPipeline:
                                                          pipeline));

                                              _searchController.clear();
                                            }

                                            _isSearchOpen.value =
                                                !_isSearchOpen.value;
                                          },
                                        ),
                                      ),
                                      if (isOpen)
                                        SizedBox(
                                          width:
                                              UIHelpers.screenWidth(context) *
                                                  0.115,
                                          child: TextField(
                                            controller: _searchController,
                                            decoration: InputDecoration(
                                              hintText: 'Search...',
                                              hintStyle: SupportBotTextstyle.medium.copyWith(color: SupportBotColors.gray.shade600),
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.only(bottom: -2),
                                            ),
                                            onSubmitted: (value) {
                                              if (value.isNotEmpty) {
                                                BlocProvider.of<PlutotableBloc>(
                                                        context)
                                                    .add(
                                                  SearchTableEvent(
                                                      ticketId: value,
                                                      selectDate: selectedDate,
                                                      selectMonth:
                                                          selectedMonth,
                                                      pipeline: pipeline),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Tooltip(
                    message: S.of(context).export,
                    child: const ExportButton(
                        icon: 'assets/icons/Export.svg',
                        selectedButtonText: "Ticket Classification"),
                  ),
                ],
              ),

            // for AI Query Answer
            if (selectedButtonText == 'AI Query Answer')
              Row(
                children: [
                  // Date dropdown
                  BlocBuilder<AiQueryChartBloc, AiQueryChartState>(
                    builder: (context, state) {
                      // DateTime selectedDate = DateTime.now();
                      if (state is AiQueryChartSuccess) {
                        selectedDate = state.selectedDate ?? DateTime.now();
                        pipeline = state.selectedPipeline ?? "";
                      }
                      return DateSelectionWidget(
                        selectedDate: selectedDate,
                        onChanged: (newDate) {
                          AIcurrentPage.value = 1;
                          AIpageSize.value = 10;
                          BlocProvider.of<AiQueryAnswerBloc>(context).add(
                              SelectedDateEvent(
                                  selectedDate: newDate,
                                  selectedPipeline: pipeline,
                                  page: AIcurrentPage.value,
                                  pageSize: AIpageSize.value));
                          BlocProvider.of<AiQueryChartBloc>(context).add(
                              SelectedChartDateEvent(
                                  selectedDate: newDate,
                                  selectedPipeline: pipeline));
                          BlocProvider.of<DashboardBloc>(context)
                              .add(UpdateSelectedDateEvent(newDate, pipeline));
                          onFilterChanged(FilterChangeType.date, newDate);
                        },
                        label: S.of(context).day,
                        isInteractive: true,
                      );
                    },
                  ),

                  UIHelpers.horizontalSpaceSmall,
                  // Classification dropdown
                  BlocBuilder<AiQueryAnswerBloc, AiQueryAnswerState>(
                    builder: (context, state) {
                      bool? selectedAIClassification;
                      String? AIclassification = 'Select';

                      if (state is AiQueryAnswerSuccess) {
                        selectedDate = state.selectedDate;
                        selectedMonth = state.selectedMonth;
                        selectedAIClassification = state.selectedClassification;
                        AIclassification = state.classification;
                        pipeline = state.selectedPipeline ?? '';
                      }

                      final classificationItems = [
                        'Select',
                        'Answered',
                        'Not Answered'
                      ];
                      return CustomFilterDropdown(
                        selectedValue: AIclassification ?? 'Select',
                        items: classificationItems,
                        onChanged: (String? value) {
                          if (value != null) {
                            isAnswer;
                            if (value == 'Answered') {
                              isAnswer = true;
                            } else if (value == 'Not Answered') {
                              isAnswer = false;
                            } else {
                              isAnswer = null;
                            }
                            AIcurrentPage.value = 1;
                            AIpageSize.value = 10;
                            BlocProvider.of<AiQueryAnswerBloc>(context,
                                    listen: false)
                                .add(
                              FetchAiQueryAnswerEvent(
                                  selectedClassification: isAnswer,
                                  selectedDate: selectedDate,
                                  selectedMonth: selectedMonth,
                                  selectedPipeline: pipeline,
                                  page: AIcurrentPage.value,
                                  pageSize: AIpageSize.value),
                            );
                            onFilterChanged(
                                FilterChangeType.AIclassification, isAnswer);
                          }
                        },
                        label: S.of(context).classification,
                        width: UIHelpers.screenWidth(context) * 0.15,
                        height: UIHelpers.screenHeight(context) * 0.05,
                      );
                    },
                  ),
                  const Spacer(),
                  Tooltip(
                    message: S.of(context).export,
                    child: const ExportButton(
                      icon: 'assets/icons/Export.svg',
                      selectedButtonText: "AI Query Answer",
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }

  String _monthToString(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1]; // Month is 1-indexed
  }

// Helper function to convert string month to DateTime
  DateTime _stringToMonth(String month) {
    const months = {
      'January': 1,
      'February': 2,
      'March': 3,
      'April': 4,
      'May': 5,
      'June': 6,
      'July': 7,
      'August': 8,
      'September': 9,
      'October': 10,
      'November': 11,
      'December': 12
    };
    return DateTime(
        2024, months[month]!); // Replace 2024 with the year you want
  }
}

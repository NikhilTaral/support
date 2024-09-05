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
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class DashboardFilterWidget extends StatelessWidget {
  String pipeline;
  DateTime? selectedDate;
  DateTime? selectedMonth;
  String selectedClassification;
  DashboardFilterWidget(
      {super.key,
      required this.pipeline,
      required this.selectedClassification,
      this.selectedDate,
      this.selectedMonth});

  final ValueNotifier<bool> _isSearchOpen = ValueNotifier<bool>(false);
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(pipeline);
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
                if (EnvConfig.ENV != 'dev' || EnvConfig.ENV != 'qa')
                  CustomButton(
                    text: S.of(context).ticketClassification,
                    isSelected: selectedButtonText == 'Ticket Classification',
                    onPressed: () {
                      BlocProvider.of<CustombuttonBloc>(context)
                          .add(SelectButtonEvent('Ticket Classification'));
                    },
                  ),
                if (EnvConfig.ENV != 'prod')
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
                          BlocProvider.of<DashboardBloc>(context)
                              .add(UpdateSelectedDateEvent(newDate, pipeline));
                          BlocProvider.of<PlutotableBloc>(context).add(
                              SelectDateEvent(
                                  selectedDate: newDate,
                                  selectedPipeline: pipeline));
                        },
                        label: S.of(context).day,
                        isInteractive: true,
                      );
                    },
                  ),
                  const SizedBox(width: 10),

                  // Month dropdown
                  BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      DateTime? selectedMonth;
                      String selectedMonthString = "January";
                      //   String pipeline = '11257490';

                      if (state is DashboardDataSuccess) {
                        selectedMonth = state.selectedMonth;
                        selectedMonthString =
                            _monthToString(selectedMonth.month);
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
                            DateTime monthDateTime = _stringToMonth(value);
                            BlocProvider.of<DashboardBloc>(context).add(
                                UpdateSelectedMonthEvent(
                                    monthDateTime, pipeline));
                            BlocProvider.of<PlutotableBloc>(context).add(
                                SelectMonthEvent(
                                    selectedMonth: monthDateTime,
                                    selectedPipeline: pipeline));
                          }
                        },
                        label: S.of(context).month,
                      );
                    },
                  ),
                  const SizedBox(width: 10),

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
                      }
                      print(pipeline);
                      final classificationItems = [
                        'Select',
                        'Spam/Marketing',
                        'No Action Required',
                        'Genuine Query',
                        'Acknowledgement Required'
                      ];
                      return CustomFilterDropdown(
                        selectedValue: selectedClassification,
                        items: classificationItems,
                        onChanged: (String? value) {
                          if (value != null) {
                            BlocProvider.of<PlutotableBloc>(context,
                                    listen: false)
                                .add(FilterClassificationEvent(
                                    selectedDate ?? null,
                                    selectedMonth,
                                    value,
                                    "",
                                    pipeline,
                                    ticketId));
                          }
                        },
                        label: S.of(context).classification,
                        width: UIHelpers.screenWidth(context) * 0.13,
                      );
                    },
                  ),
                  const SizedBox(width: 10),

                  // Validation dropdown
                  BlocBuilder<PlutotableBloc, PlutotableState>(
                    builder: (context, state) {
                      String selectedValidation = '';
                      // String? pipeline = '11257490';
                      String? ticketId = '';
                      if (state is FetchTableDataSuccess) {
                        selectedDate = state.selectedDate ?? null;
                        selectedMonth = state.selectedMonth;
                        selectedClassification = state.selectedClassification;
                        selectedValidation = state.selectedValidation ?? '';
                      }
                      final validationItems = [
                        'Select',
                        'correct',
                        'incorrect'
                      ];
                      return CustomFilterDropdown(
                        selectedValue: selectedValidation,
                        items: validationItems,
                        onChanged: (String? value) {
                          if (value != null) {
                            BlocProvider.of<PlutotableBloc>(context,
                                    listen: false)
                                .add(FilterValidationEvent(
                                    value,
                                    selectedDate ?? null,
                                    selectedMonth,
                                    selectedClassification,
                                    pipeline,
                                    ticketId));
                          }
                        },
                        label: S.of(context).validation,
                        width: UIHelpers.screenWidth(context) * 0.13,
                      );
                    },
                  ),
                  const Spacer(),
                  BlocBuilder<PlutotableBloc, PlutotableState>(
                    builder: (context, state) {
                      if (state is FetchTableDataSuccess) {
                        selectedDate = state.selectedDate ?? null;
                        selectedMonth = state.selectedMonth;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _isSearchOpen,
                          builder: (context, isOpen, child) {
                            return Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height:
                                      UIHelpers.screenHeight(context) * 0.05,
                                  decoration: isOpen
                                      ? BoxDecoration(
                                          color: SupportBotColors.gray.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: SupportBotColors.gray),
                                        )
                                      : null,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          isOpen ? Icons.close : Icons.search,
                                          size: 23,
                                        ),
                                        onPressed: () {
                                          if (isOpen) {
                                            BlocProvider.of<PlutotableBloc>(
                                                    context)
                                                .add(FetchTableDataEvent(
                                                    selectedDate: selectedDate,
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
                                      if (isOpen)
                                        SizedBox(
                                          width:
                                              UIHelpers.screenWidth(context) *
                                                  0.1,
                                          child: TextField(
                                            controller: _searchController,
                                            decoration: const InputDecoration(
                                              hintText: 'Search...',
                                              border: InputBorder.none,
                                              isDense: true,
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
                  BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      DateTime selectedDate = DateTime.now();
                      if (state is DashboardDataSuccess) {
                        selectedDate = state.selectedDate ?? DateTime.now();
                      }
                      return DateSelectionWidget(
                        selectedDate: selectedDate,
                        onChanged: (newDate) {
                          BlocProvider.of<AiQueryAnswerBloc>(context)
                              .add(SelectedDateEvent(selectedDate: newDate));
                          BlocProvider.of<AiQueryChartBloc>(context).add(
                              SelectedChartDateEvent(selectedDate: newDate));
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
                      bool? selectedClassification = null;
                      String? classification = 'Select';

                      if (state is AiQueryAnswerSuccess) {
                        selectedDate = state.selectedDate;
                        selectedMonth = state.selectedMonth;
                        selectedClassification = state.selectedClassification;
                        classification = state.classification;
                      }

                      final classificationItems = [
                        'Select',
                        'Answered',
                        'Not Answered'
                      ];
                      return CustomFilterDropdown(
                        selectedValue: classification ?? 'Select',
                        items: classificationItems,
                        onChanged: (String? value) {
                          if (value != null) {
                            bool? isAnswer;
                            if (value == 'Answered') {
                              isAnswer = true;
                            } else if (value == 'Not Answered') {
                              isAnswer = false;
                            } else {
                              isAnswer = null;
                            }
                            BlocProvider.of<AiQueryAnswerBloc>(context,
                                    listen: false)
                                .add(
                              FilterAiAnsweClassificationEvent(
                                selectedClassification: isAnswer,
                                selectDate: selectedDate,
                                selectMonth: selectedMonth,
                              ),
                            );
                          }
                        },
                        label: S.of(context).classification,
                        width: UIHelpers.screenWidth(context) * 0.14,
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

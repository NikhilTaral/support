import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/header/nav_bar.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_pipeline_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_answer/ai_query_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_chart_bloc/ai_query_chart_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/custom_button_bloc/custombutton_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_pipeline/dashboard_pipeline_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_ai_query_answer_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_count_container.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_count_container_data.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_date_selection_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_pie_chart_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_pipeline_filter_dropdown_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_ticket_classification_table_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_button.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_filter_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_month_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/export_button.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';
import 'package:support_bot_dashboard/config/environment/env_config.dart';

class DashboardDesktopView extends StatelessWidget {
  DashboardDesktopView({Key? key}) : super(key: key);

  final ValueNotifier<bool> _isSearchOpen = ValueNotifier<bool>(false);
  final TextEditingController _searchController = TextEditingController();

  String? pipeline = '11257490';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<DashboardBloc>()
            ..add(FetchDashboardDataEvent(
                DateTime.now(), DateTime(2024 - 01), pipeline)),
        ),
        BlocProvider(
          create: (context) => serviceLocator<PlutotableBloc>()
            ..add(
              FetchTableDataEvent(
                  selectedDate: DateTime.now(),
                  selectedMonth: DateTime(2024, 1),
                  selectedPipeline: pipeline),
            ),
        ),
        BlocProvider(
          create: (context) => serviceLocator<CustombuttonBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AiQueryAnswerBloc>()
            ..add(
              FetchAiQueryAnswerEvent(
                  selectedDate: DateTime.now(),
                  selectedMonth: DateTime(2024, 1)),
            ),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AiQueryChartBloc>()
            ..add(
              FetchAiQueryChartData(
                  selectedDate: DateTime.now(),
                  selectedMonth: DateTime(2024 - 01)),
            ),
        ),
        // BlocProvider(
        //   create: (context) => serviceLocator<UpdateAiAnswerBloc>()
        //     ..add(
        //       UpdateAiAnswerInitialEvent(
        //           ticketId: "",
        //           newAnswer: "",
        //           selectedDate: DateTime.now(),
        //           selectedMonth: DateTime(2024 - 01)),
        //     ),
        // ),
        BlocProvider(
            create: (context) => serviceLocator<DashboardPipelineBloc>()
              ..add(FilterPipelineEvent(
                  DateTime.now(), null, 'Expert Care Level 1')))
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              NavBar(
                showPopArrow: false,
                navigateTo: () {},
                text: "",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Row(
                  children: [
                    Flexible(
                      flex: 8,
                      child: Column(
                        children: [
                          BlocBuilder<DashboardBloc, DashboardState>(
                            builder: (context, state) {
                              if (state is DashboardDataLoading) {
                                return Center(
                                  child: LoadingWidget(
                                    width:
                                        UIHelpers.screenWidth(context) * 0.78,
                                    height:
                                        UIHelpers.screenHeight(context) * 0.2,
                                    radius: 8,
                                  ),
                                );
                              } else if (state is DashboardDataSuccess) {
                                num totalCount = (state
                                            .pieChartData?.spamMarketing ??
                                        0) +
                                    (state.pieChartData?.noActionRequired ??
                                        0) +
                                    (state.pieChartData?.genuineQuery ?? 0) +
                                    (state.pieChartData?.acknowledgement ?? 0);

                                final List<CountContainerData> countContainers =
                                    getCountContainerData(context,
                                        state: state, totalCount: totalCount);

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      countContainers.length, (index) {
                                    final data = countContainers[index];
                                    return CountContainer(
                                      text: data.text,
                                      icon: data.iconPath,
                                      count: data.count,
                                    );
                                  }),
                                );
                              } else if (state is DashboardDataError) {
                                final List<CountContainerData> countContainers =
                                    getCountContainerData(context);

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      countContainers.length, (index) {
                                    final data = countContainers[index];
                                    return CountContainer(
                                      text: data.text,
                                      icon: data.iconPath,
                                      count: data.count,
                                    );
                                  }),
                                );
                              } else {
                                final List<CountContainerData> countContainers =
                                    getCountContainerData(context);

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      countContainers.length, (index) {
                                    final data = countContainers[index];
                                    return CountContainer(
                                      text: data.text,
                                      icon: data.iconPath,
                                      count: data.count,
                                    );
                                  }),
                                );
                              }
                            },
                          ),
                          UIHelpers.verticalSpaceRegular,
                          BlocBuilder<CustombuttonBloc, CustombuttonState>(
                            builder: (context, state) {
                              String selectedButtonText = '';
                              if (state is ButtonSelectedState) {
                                selectedButtonText = state.selectedButtonText;
                              }
                              if (state is CustomButtonInitial &&
                                  state.selectedButtonText ==
                                      'Ticket Classification') {
                                selectedButtonText = state.selectedButtonText;
                              }

                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      if (EnvConfig.ENV != 'dev' ||
                                          EnvConfig.ENV != 'qa')
                                        CustomButton(
                                          text: S
                                              .of(context)
                                              .ticketClassification,
                                          isSelected: selectedButtonText ==
                                              'Ticket Classification',
                                          onPressed: () {
                                            BlocProvider.of<CustombuttonBloc>(
                                                    context)
                                                .add(SelectButtonEvent(
                                                    'Ticket Classification'));
                                          },
                                        ),
                                      if (EnvConfig.ENV != 'prod')
                                        CustomButton(
                                          text: S.of(context).aiQueryAnswer,
                                          isSelected: selectedButtonText ==
                                              'AI Query Answer',
                                          onPressed: () {
                                            BlocProvider.of<CustombuttonBloc>(
                                                    context)
                                                .add(SelectButtonEvent(
                                                    'AI Query Answer'));
                                          },
                                        ),
                                    ],
                                  ),
                                  // for Ticket Classification
                                  if (selectedButtonText ==
                                      'Ticket Classification')
                                    Row(
                                      children: [
                                        // Date dropdown
                                        BlocBuilder<DashboardBloc,
                                            DashboardState>(
                                          builder: (context, state) {
                                            DateTime selectedDate =
                                                DateTime.now();
                                           // String pipeline = '11257490';
                                            if (state is DashboardDataSuccess) {
                                              selectedDate = state.selectedDate;
                                              pipeline =
                                                  state.selectedPipeline;
                                            }
                                            return DateSelectionWidget(
                                              selectedDate: selectedDate,
                                              onChanged: (newDate) {
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(
                                                        UpdateSelectedDateEvent(
                                                            newDate, pipeline));
                                                BlocProvider.of<PlutotableBloc>(
                                                        context)
                                                    .add(SelectDateEvent(
                                                        selectedDate: newDate,
                                                        selectedPipeline:
                                                            pipeline));
                                              },
                                              label: S.of(context).day,
                                              isInteractive: true,
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 10),

                                        // Month dropdown
                                        BlocBuilder<DashboardBloc,
                                            DashboardState>(
                                          builder: (context, state) {
                                            DateTime selectedMonth =
                                                DateTime(2024, 1);
                                            String selectedMonthString =
                                                "January";
                                         //   String pipeline = '11257490';

                                            if (state is DashboardDataSuccess) {
                                              selectedMonth =
                                                  state.selectedMonth;
                                              selectedMonthString =
                                                  _monthToString(
                                                      selectedMonth.month);
                                              pipeline =
                                                  state.selectedPipeline;
                                            }
                                            return CustomMonthDropdown(
                                              selectedValue:
                                                  selectedMonthString,
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
                                                  DateTime monthDateTime =
                                                      _stringToMonth(value);
                                                  BlocProvider.of<
                                                              DashboardBloc>(
                                                          context)
                                                      .add(
                                                          UpdateSelectedMonthEvent(
                                                              monthDateTime,
                                                              pipeline));
                                                  BlocProvider.of<
                                                              PlutotableBloc>(
                                                          context)
                                                      .add(SelectMonthEvent(
                                                          selectedMonth:
                                                              monthDateTime,
                                                          selectedPipeline:
                                                              pipeline));
                                                }
                                              },
                                              label: S.of(context).month,
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 10),

                                        // Classification dropdown
                                        BlocBuilder<PlutotableBloc,
                                            PlutotableState>(
                                          builder: (context, state) {
                                            DateTime? selectedDate;
                                            DateTime selectedMonth =
                                                DateTime(2024, 01);
                                            String selectedClassification = '';
                                           // String? pipeline = '11257490';
                                            String? ticketId ='';
                                            if (state
                                                is FetchTableDataSuccess) {
                                                   print(state.selectedDate);
                                              selectedDate = state.selectedDate;
                                              selectedMonth =
                                                  state.selectedMonth;
                                              selectedClassification =
                                                  state.selectedClassification;
                                              pipeline = state.selectedPipeline;
                                              ticketId = state.ticketId;
                                            }
                                           
                                            final classificationItems = [
                                              'Select',
                                              'Spam/Marketing',
                                              'No Action Required',
                                              'Genuine Query',
                                              'Acknowledgement Required'
                                            ];
                                            return CustomFilterDropdown(
                                              selectedValue:
                                                  selectedClassification,
                                              items: classificationItems,
                                              onChanged: (String? value) {
                                                if (value != null) {
                                                  BlocProvider.of<
                                                              PlutotableBloc>(
                                                          context,
                                                          listen: false)
                                                      .add(
                                                          FilterClassificationEvent(
                                                              selectedDate ?? null,
                                                              selectedMonth,
                                                              value,
                                                              "",pipeline,ticketId));
                                                }
                                              },
                                              label:
                                                  S.of(context).classification,
                                              width: UIHelpers.screenWidth(
                                                      context) *
                                                  0.13,
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 10),

                                        // Validation dropdown
                                        BlocBuilder<PlutotableBloc,
                                            PlutotableState>(
                                          builder: (context, state) {
                                            DateTime? selectedDate =
                                                DateTime.now();
                                            DateTime selectedMonth =
                                                DateTime(2024, 01);
                                            String selectedClassification = '';
                                            String selectedValidation = '';
                                            // String? pipeline = '11257490';
                                            String? ticketId ='';
                                            if (state
                                                is FetchTableDataSuccess) {
                                              selectedDate = state.selectedDate ?? null;
                                              selectedMonth =
                                                  state.selectedMonth;
                                              selectedClassification =
                                                  state.selectedClassification;
                                              selectedValidation =
                                                  state.selectedValidation ??
                                                      '';
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
                                                  BlocProvider.of<
                                                              PlutotableBloc>(
                                                          context,
                                                          listen: false)
                                                      .add(FilterValidationEvent(
                                                          value,
                                                          selectedDate ?? null,
                                                          selectedMonth,
                                                          selectedClassification,pipeline,ticketId));
                                                }
                                              },
                                              label: S.of(context).validation,
                                              width: UIHelpers.screenWidth(
                                                      context) *
                                                  0.13,
                                            );
                                          },
                                        ),
                                        const Spacer(),
                                        BlocBuilder<PlutotableBloc,
                                            PlutotableState>(
                                          builder: (context, state) {
                                            DateTime? date = DateTime.now();
                                            DateTime month = DateTime(2024, 01);
                                            if (state
                                                is FetchTableDataSuccess) {
                                              date = state.selectedDate ?? null;
                                              month = state.selectedMonth;
                                            }
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child:
                                                  ValueListenableBuilder<bool>(
                                                valueListenable: _isSearchOpen,
                                                builder:
                                                    (context, isOpen, child) {
                                                  return Row(
                                                    children: [
                                                      AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        height: UIHelpers
                                                                .screenHeight(
                                                                    context) *
                                                            0.05,
                                                        decoration: isOpen
                                                            ? BoxDecoration(
                                                                color:
                                                                    SupportBotColors
                                                                        .gray
                                                                        .shade100,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                border: Border.all(
                                                                    color: SupportBotColors
                                                                        .gray),
                                                              )
                                                            : null,
                                                        child: Row(
                                                          children: [
                                                            IconButton(
                                                              icon: Icon(
                                                                isOpen
                                                                    ? Icons
                                                                        .close
                                                                    : Icons
                                                                        .search,
                                                                size: 23,
                                                              ),
                                                              onPressed: () {
                                                                _isSearchOpen
                                                                        .value =
                                                                    !_isSearchOpen
                                                                        .value;
                                                              },
                                                            ),
                                                            if (isOpen)
                                                              SizedBox(
                                                                width: UIHelpers
                                                                        .screenWidth(
                                                                            context) *
                                                                    0.1,
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      _searchController,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    hintText:
                                                                        'Search...',
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    isDense:
                                                                        true,
                                                                  ),
                                                                  onSubmitted:
                                                                      (value) {
                                                                    if (value
                                                                        .isNotEmpty) {
                                                                      BlocProvider.of<PlutotableBloc>(
                                                                              context)
                                                                          .add(
                                                                        SearchTableEvent(
                                                                          ticketId:
                                                                              value,
                                                                          selectDate:
                                                                              date,
                                                                          selectMonth:
                                                                              month,
                                                                        ),
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
                                              selectedButtonText:
                                                  "Ticket Classification"),
                                        ),
                                      ],
                                    ),

                                  // for AI Query Answer
                                  if (selectedButtonText == 'AI Query Answer')
                                    Row(
                                      children: [
                                        // Date dropdown
                                        BlocBuilder<DashboardBloc,
                                            DashboardState>(
                                          builder: (context, state) {
                                            DateTime selectedDate =
                                                DateTime.now();
                                            if (state is DashboardDataSuccess) {
                                              selectedDate = state.selectedDate;
                                            }
                                            return DateSelectionWidget(
                                              selectedDate: selectedDate,
                                              onChanged: (newDate) {
                                                BlocProvider.of<
                                                            AiQueryAnswerBloc>(
                                                        context)
                                                    .add(SelectedDateEvent(
                                                        selectedDate: newDate));
                                                BlocProvider.of<
                                                            AiQueryChartBloc>(
                                                        context)
                                                    .add(SelectedChartDateEvent(
                                                        selectedDate: newDate));
                                              },
                                              label: S.of(context).day,
                                              isInteractive: true,
                                            );
                                          },
                                        ),
                                        
                                        UIHelpers.horizontalSpaceSmall,
                                        // Classification dropdown
                                        BlocBuilder<AiQueryAnswerBloc,
                                            AiQueryAnswerState>(
                                          builder: (context, state) {
                                            DateTime selectedDate =
                                                DateTime.now();
                                            DateTime selectedMonth =
                                                DateTime(2024, 01);
                                            bool? selectedClassification = null;
                                            String? classification = 'Select';

                                            if (state is AiQueryAnswerSuccess) {
                                              selectedDate = state.selectedDate;
                                              selectedMonth =
                                                  state.selectedMonth;
                                              selectedClassification =
                                                  state.selectedClassification;
                                              classification =
                                                  state.classification;
                                            }

                                            final classificationItems = [
                                              'Select',
                                              'Answered',
                                              'Not Answered'
                                            ];
                                            return CustomFilterDropdown(
                                              selectedValue:
                                                  classification ?? 'Select',
                                              items: classificationItems,
                                              onChanged: (String? value) {
                                                if (value != null) {
                                                  bool? isAnswer;
                                                  if (value == 'Answered') {
                                                    isAnswer = true;
                                                  } else if (value ==
                                                      'Not Answered') {
                                                    isAnswer = false;
                                                  } else {
                                                    isAnswer = null;
                                                  }
                                                  BlocProvider.of<
                                                              AiQueryAnswerBloc>(
                                                          context,
                                                          listen: false)
                                                      .add(
                                                    FilterAiAnsweClassificationEvent(
                                                      selectedClassification:
                                                          isAnswer,
                                                      selectDate: selectedDate,
                                                      selectMonth:
                                                          selectedMonth,
                                                    ),
                                                  );
                                                }
                                              },
                                              label:
                                                  S.of(context).classification,
                                              width: UIHelpers.screenWidth(
                                                      context) *
                                                  0.14,
                                            );
                                          },
                                        ),
                                        const Spacer(),
                                        Tooltip(
                                          message: S.of(context).export,
                                          child: const ExportButton(
                                            icon: 'assets/icons/Export.svg',
                                            selectedButtonText:
                                                "AI Query Answer",
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              );
                            },
                          ),
                          BlocBuilder<CustombuttonBloc, CustombuttonState>(
                            builder: (context, state) {
                              if (state is CustomButtonInitial ||
                                  (state is ButtonSelectedState &&
                                      state.selectedButtonText ==
                                          'Ticket Classification')) {
                                return BlocConsumer<PlutotableBloc,
                                    PlutotableState>(
                                  listener: (context, state) {
                                    if (state is UpdateValidationSuccess) {
                                      context.read<PlutotableBloc>().add(
                                            FetchTableDataEvent(
                                              selectedDate: state.selectedDate,
                                              selectedMonth:
                                                  state.selectedMonth,
                                            ),
                                          );
                                    } else if (state
                                            is UpdateValidationSuccess ||
                                        state is UpdateValidationError) {
                                      context.read<PlutotableBloc>().add(
                                            FetchTableDataEvent(
                                              selectedDate: DateTime.now(),
                                              selectedMonth: DateTime(2024, 1),
                                            ),
                                          );
                                      Navigator.of(context).pop();
                                    } else if (state
                                        is RevertClassificationSuccessState) {
                                      context.read<PlutotableBloc>().add(
                                            FetchTableDataEvent(
                                                selectedDate:
                                                    state.selectedDate,
                                                selectedMonth:
                                                    state.selectedMonth,
                                                selectedClassification: state
                                                    .selectedClassification),
                                          );
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is UpdateValidationLoading) {
                                      return Center(
                                        child: LoadingWidget(
                                          height:
                                              UIHelpers.screenHeight(context) *
                                                  0.43,
                                          width:
                                              UIHelpers.screenWidth(context) *
                                                  0.78,
                                          radius: 8,
                                        ),
                                      );
                                    }
                                    if (state
                                        is RevertClassificationLoadingState) {
                                      return Center(
                                        child: LoadingWidget(
                                          height:
                                              UIHelpers.screenHeight(context) *
                                                  0.43,
                                          width:
                                              UIHelpers.screenWidth(context) *
                                                  0.78,
                                          radius: 8,
                                        ),
                                      );
                                    }
                                    if (state is FetchTableDataLoading) {
                                      return Center(
                                          child: LoadingWidget(
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.43,
                                        width: UIHelpers.screenWidth(context) *
                                            0.78,
                                        radius: 8,
                                      ));
                                    } else if (state is FetchTableDataEmpty) {
                                      return SizedBox(
                                          height:
                                              UIHelpers.screenHeight(context) *
                                                  0.5,
                                          child: const Center(
                                              child: EmptyWidget()));
                                    } else if (state is FetchTableDataSuccess) {
                                      if (state.noDataAvailable) {
                                        return SizedBox(
                                            height: UIHelpers.screenHeight(
                                                    context) *
                                                0.5,
                                            child: const Center(
                                                child: EmptyWidget()));
                                      }
                                      return TicketClassificationTableWidget(
                                        tableData: state.tableData,
                                        selectedDate: state.selectedDate ?? null,
                                        selectedMonth: state.selectedMonth,
                                      );
                                    } else if (state is FetchTableDataError) {
                                      return SizedBox(
                                          height:
                                              UIHelpers.screenHeight(context) *
                                                  0.5,
                                          child: const Center(
                                              child: EmptyWidget()));
                                    } else {
                                      return Container();
                                    }
                                  },
                                );
                              } else {
                                return BlocConsumer<AiQueryAnswerBloc,
                                        AiQueryAnswerState>(
                                    listener: (context, state) {
                                  if (state is UpdateAiAnswerSuccessState) {
                                    context.read<AiQueryAnswerBloc>().add(
                                        FetchAiQueryAnswerEvent(
                                            selectedDate: state.selectedDate,
                                            selectedMonth:
                                                state.selectedMonth));
                                  }
                                }, builder: (context, state) {
                                  if (state is AiQueryAnswerLoading) {
                                    return Center(
                                        child: LoadingWidget(
                                      height: UIHelpers.screenHeight(context) *
                                          0.43,
                                      width:
                                          UIHelpers.screenWidth(context) * 0.78,
                                      radius: 8,
                                    ));
                                  } else if (state is AiQueryAnswerEmpty) {
                                    return SizedBox(
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.5,
                                        child:
                                            const Center(child: EmptyWidget()));
                                  } else if (state is AiQueryAnswerSuccess) {
                                    return AIQueryAnswerWidget(
                                      aiQuerytableData: state.data,
                                      selectedDate: state.selectedDate,
                                      selectedMonth: state.selectedMonth,
                                    );
                                  } else if (state is AiQUeryAnswerFailure) {
                                    return SizedBox(
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.5,
                                        child:
                                            const Center(child: EmptyWidget()));
                                  } else {
                                    return Container();
                                  }
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<CustombuttonBloc, CustombuttonState>(
                        builder: (context, state) {
                      if (state is CustomButtonInitial ||
                          (state is ButtonSelectedState &&
                              state.selectedButtonText ==
                                  'Ticket Classification')) {
                        return Flexible(
                          flex: 2,
                          child: Column(
                            children: [
                              BlocBuilder<DashboardPipelineBloc,
                                  DashboardPipelineState>(
                                builder: (context, state) {
                                  if (state is DashboardPipelineLoading) {
                                    return LoadingWidget(
                                      width:
                                          UIHelpers.screenWidth(context) * 0.19,
                                      height: UIHelpers.screenHeight(context) *
                                          0.05,
                                      radius: 8,
                                    );
                                  } else if (state
                                      is DashboardPipelineFailure) {
                                    return Text(state.message);
                                  } else if (state
                                      is DashboardPipelineSuccess) {
                                    DateTime selectedMonth = state
                                        .selectedMonth; 
                                    DateTime? selectedDate = state.selectedDate;
                                    String selectedMonthString = _monthToString(
                                        selectedMonth
                                            .month); 
                                    pipeline = state.selectedPipelineValue;
                                    Map<String, String> pipelineNameToIdMap = {
                                      for (var item in state
                                              .dashboardPipelineAttributeModel
                                              ?.data ??
                                          [])
                                        item.pipelineName: item.pipelineId,
                                    };

                                    List<String?> dropdownItems =
                                        pipelineNameToIdMap.keys.toList();

                                    return SizedBox(
                                      width: UIHelpers.screenWidth(context),
                                      child:
                                          DashboardPipelineFilterDropdownWidget(
                                        selectedValue:
                                            pipeline,
                                        items: dropdownItems,
                                        onChanged: (String? value) {
                                          if (value != null) {
                                            final selectedPipelineId =
                                                pipelineNameToIdMap[value];
                                            BlocProvider.of<PlutotableBloc>(
                                                    context)
                                                .add(
                                              FetchTableDataEvent(
                                                selectedDate:
                                                    state.selectedDate,
                                                selectedMonth: selectedMonth,
                                                selectedPipeline:
                                                    selectedPipelineId,
                                              ),
                                            );

                                            BlocProvider.of<DashboardBloc>(
                                                    context)
                                                .add(FetchDashboardDataEvent(
                                                    state.selectedDate,
                                                    selectedMonth,
                                                    selectedPipelineId));

                                            BlocProvider.of<
                                                        DashboardPipelineBloc>(
                                                    context,
                                                    listen: false)
                                                .add(
                                              UpdateSelectedPipelineEvent(
                                                selectedDate: selectedDate,
                                                selectedMonth: selectedMonth,
                                                selectedPipelineValue: value,
                                              ),
                                            );
                                          }
                                        },
                                        label: S.of(context).pipelineType,
                                        width: UIHelpers.screenWidth(context) *
                                            0.18,
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              BlocBuilder<DashboardBloc, DashboardState>(
                                builder: (context, state) {
                                  if (state is DashboardDataLoading) {
                                    return LoadingWidget(
                                      width:
                                          UIHelpers.screenWidth(context) * 0.19,
                                      height: UIHelpers.screenHeight(context) *
                                          0.75,
                                      radius: 8,
                                    );
                                  } else if (state is DashboardDataSuccess) {
                                    return PieChartWidget(
                                        data: state.pieChartData,
                                        isAIQuery: false);
                                  } else if (state is DashboardDataError) {
                                    return SizedBox(
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.75,
                                        child:
                                            const Center(child: EmptyWidget()));
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Flexible(
                          flex: 2,
                          child: Column(
                            children: [
                              // BlocBuilder<PlutotableBloc, PlutotableState>(
                              //   builder: (context, state) {
                              //     DateTime selectedDate = DateTime.now();
                              //     DateTime selectedMonth = DateTime(2024, 01);
                              //     String selectedPipeline = 'ECD';
                              //     if (state is FetchTableDataSuccess) {
                              //       selectedDate = state.selectedDate;
                              //       selectedMonth = state.selectedMonth;
                              //       selectedPipeline = state.selectedPipeline;
                              //     }
                              //     final pipelineItems = [
                              //       'ECD',
                              //       'Southwest Broker',
                              //     ];

                              //     // Ensure selectedPipeline is in the list
                              //     if (!pipelineItems
                              //         .contains(selectedPipeline)) {
                              //       selectedPipeline = pipelineItems.first;
                              //     }

                              //     return SizedBox(
                              //       width: UIHelpers.screenWidth(context),
                              //       child:
                              //           DashboardPipelineFilterDropdownWidget(
                              //         selectedValue: selectedPipeline,
                              //         items: pipelineItems,
                              //         onChanged: (String? value) {
                              //           if (value != null) {
                              //             // BlocProvider.of<PlutotableBloc>(
                              //             //         context,
                              //             //         listen: false)
                              //             //     .add(
                              //             //   FilterPipelineEvent(selectedDate,
                              //             //       selectedMonth, value),
                              //             // );
                              //           }
                              //         },
                              //         label: S.of(context).pipelineType,
                              //         width:
                              //             UIHelpers.screenWidth(context) * 0.18,
                              //       ),
                              //     );
                              //   },
                              // ),
                              BlocBuilder<AiQueryChartBloc, AiQueryChartState>(
                                builder: (context, state) {
                                  if (state is AiQueryChartLoading) {
                                    return Center(
                                      child: LoadingWidget(
                                        width: UIHelpers.screenWidth(context) *
                                            0.19,
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.75,
                                        radius: 8,
                                      ),
                                    );
                                  } else if (state is AiQueryChartSuccess) {
                                    return PieChartWidget(
                                        data: state.pieChartData,
                                        isAIQuery: true);
                                  } else if (state is AiQueryChartFailure) {
                                    return SizedBox(
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.75,
                                        child:
                                            const Center(child: EmptyWidget()));
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to convert month index to string
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

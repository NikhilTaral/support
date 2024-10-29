import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/header/nav_bar.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_answer/ai_query_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_chart_bloc/ai_query_chart_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/custom_button_bloc/custombutton_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_pipeline/dashboard_pipeline_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/export_bloc/export_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_ai_query_answer_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_count_container.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_count_container_data.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_filter_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_pie_chart_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_pipeline_filter_dropdown_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_ticket_classification_table_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class DashboardDesktopView extends StatelessWidget {
  DashboardDesktopView(
      {Key? key,
      required this.pipeline,
      required this.selectedPipelineId,
      required this.isAIAnswer})
      : super(key: key);

  late String pipeline;
  DateTime? selectedDate = DateTime.now();
  DateTime? selectedMonth = DateTime(2024 - 01);
  String? selectedClassification = '';
  String? selectedClassificationValidation;
  late String selectedPipelineId;
  late bool isAIAnswer;
  bool? isAnswer;
  final ValueNotifier<int> currentPage = ValueNotifier<int>(1);
  final ValueNotifier<int> pageSize = ValueNotifier<int>(10);
  final ValueNotifier<int> AIcurrentPage = ValueNotifier<int>(1);
  final ValueNotifier<int> AIpageSize = ValueNotifier<int>(10);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => serviceLocator<DashboardBloc>()
              ..add(FetchDashboardDataEvent(
                  selectedDate: DateTime.now(),
                  selectedMonth: null,
                  selectedPipeline: pipeline))
              ..add(GetValidationCountEvent(
                  selectedDate: DateTime.now(),
                  selectedMonth: null,
                  selectedPipeline: pipeline))
              ..add(GetValidationByCountEvent(
                  selectedDate: DateTime.now(),
                  selectedMonth: null,
                  selectedPipeline: pipeline))
              ..add(GetUserSettingsEvent())
          ),
        BlocProvider(
          create: (context) => serviceLocator<PlutotableBloc>()
            ..add(
              FetchTableDataEvent(
                  selectedDate: DateTime.now(),
                  selectedMonth: null,
                  selectedPipeline: pipeline,
                  page: currentPage.value,
                  pageSize: pageSize.value),
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
                  selectedMonth: null,
                  selectedPipeline: selectedPipelineId,
                  selectedClassification: null,
                  page: AIcurrentPage.value,
                  pageSize: AIpageSize.value),
            ),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AiQueryChartBloc>()
            ..add(
              FetchAiQueryChartData(
                  selectedDate: DateTime.now(),
                  selectedMonth: null,
                  selectedPipeline: selectedPipelineId),
            ),
        ),
        BlocProvider(
            create: (context) => serviceLocator<DashboardPipelineBloc>()
              ..add(FilterPipelineEvent(
                  DateTime.now(), null, 'Expert Care Level 1'))),
        BlocProvider(create: (context)=> serviceLocator<ExportBloc>())
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
                                    (state.pieChartData?.acknowledgement ?? 0) +
                                    (state.pieChartData?.notClassified ?? 0);

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
                          DashboardFilterWidget(
                            selectedClassification: selectedClassification,
                            pipeline: pipeline,
                            selectedDate: selectedDate,
                            selectedClassificationValidation:
                                selectedClassificationValidation ?? "",
                            isAnswer: isAnswer,
                            onFilterChanged: (FilterChangeType changeType,
                                dynamic newValue) {
                              switch (changeType) {
                                case FilterChangeType.date:
                                  selectedDate = newValue;

                                  break;
                                case FilterChangeType.month:
                                  selectedMonth = newValue;

                                  break;
                                case FilterChangeType.classification:
                                  selectedClassification = newValue;

                                  break;
                                case FilterChangeType.validation:
                                  selectedClassificationValidation = newValue;

                                case FilterChangeType.AIclassification:
                                  isAnswer = newValue;

                                  break;
                              }
                            },
                            currentPage: currentPage,
                            pageSize: pageSize,
                            AIcurrentPage: AIcurrentPage,
                            AIpageSize: AIpageSize,
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
                                                selectedDate:
                                                    state.selectedDate,
                                                selectedMonth:
                                                    state.selectedMonth,
                                                selectedPipeline:
                                                    selectedPipelineId,
                                                selectedClassification:
                                                    selectedClassification,
                                                selectedClassificationValidation:
                                                    selectedClassificationValidation
                                                        ?.toLowerCase()),
                                          );
                                    } else if (state
                                            is UpdateValidationSuccess ||
                                        state is UpdateValidationError) {
                                      context.read<PlutotableBloc>().add(
                                            FetchTableDataEvent(
                                                selectedDate: DateTime.now(),
                                                selectedMonth: null,
                                                selectedPipeline:
                                                    selectedPipelineId,
                                                selectedClassification:
                                                    selectedClassification,
                                                selectedClassificationValidation:
                                                    selectedClassificationValidation
                                                        ?.toLowerCase()),
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
                                                selectedPipeline:
                                                    selectedPipelineId,
                                                selectedClassification: state
                                                    .selectedClassification),
                                          );
                                    } else if (state
                                        is UnRevertClassificationSuccessState) {
                                      context.read<PlutotableBloc>().add(
                                            FetchTableDataEvent(
                                                selectedDate:
                                                    state.selectedDate,
                                                selectedMonth:
                                                    state.selectedMonth,
                                                selectedPipeline:
                                                    selectedPipelineId,
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
                                    if (state
                                        is UnRevertClassificationLoadingState) {
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
                                      if (state.noDataAvailable == true) {
                                        return SizedBox(
                                            height: UIHelpers.screenHeight(
                                                    context) *
                                                0.5,
                                            child: const Center(
                                                child: EmptyWidget()));
                                      }
                                      return TicketClassificationTableWidget(
                                        tableData: state.tableData,
                                        selectedDate:
                                            state.selectedDate ?? selectedDate,
                                        selectedMonth: state.selectedMonth,
                                        pipeline: pipeline,
                                        pipelineId: selectedPipelineId,
                                        currentPage: currentPage,
                                        pageSize: pageSize,
                                        selectedClassification:
                                            selectedClassification,
                                        selectedClassificationValidation:
                                            selectedClassificationValidation,
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
                                            selectedPipeline:
                                                selectedPipelineId,
                                            selectedMonth: state.selectedMonth,
                                            selectedClassification: isAnswer));
                                  }
                                }, builder: (context, state) {
                                  if (state is AiQueryAnswerLoading) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: LoadingWidget(
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.43,
                                        width: UIHelpers.screenWidth(context) *
                                            0.78,
                                        radius: 8,
                                      ),
                                    );
                                  } else if (state is AiQueryAnswerEmpty) {
                                    return SizedBox(
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.5,
                                        child:
                                            const Center(child: EmptyWidget()));
                                  } else if (state is AiQueryAnswerSuccess) {
                                    if (isAIAnswer) {
                                      return AIQueryAnswerWidget(
                                        pipeline: selectedPipelineId,
                                        aiQuerytableData: state.data,
                                        selectedDate: state.selectedDate,
                                        selectedMonth: state.selectedMonth,
                                        currentPage: AIcurrentPage,
                                        pageSize: AIpageSize,
                                        pipelineId: selectedPipelineId,
                                        isAnswer: isAnswer,
                                      );
                                    }
                                    return SizedBox(
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.5,
                                        child: Center(
                                            child: Text(
                                          'AI Answer is not enable for this pipeline',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        )));
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
                                    return FailureWidget(
                                        width: UIHelpers.screenWidth(context) *
                                            0.19,
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.05,
                                        color: SupportBotColors.gray);
                                  } else if (state
                                      is DashboardPipelineSuccess) {
                                    pipeline =
                                        state.selectedPipelineValue ?? "";
                                    Map<String, dynamic>
                                        pipelineNameToAttributesMap = {
                                      for (var item in state
                                              .dashboardPipelineAttributeModel
                                              ?.data ??
                                          [])
                                        item.pipelineName: {
                                          'pipelineId': item.pipelineId,
                                          'aiAnswerPerm': item.aiAnswerPerm,
                                        },
                                    };

                                    List<String?> dropdownItems =
                                        pipelineNameToAttributesMap.keys
                                            .toList();

                                    return SizedBox(
                                      width: UIHelpers.screenWidth(context),
                                      child:
                                          DashboardPipelineFilterDropdownWidget(
                                        selectedValue: pipeline,
                                        items: dropdownItems,
                                        onChanged: (String? value) {
                                          if (value != null) {
                                            var selectedPipelineAttributes =
                                                pipelineNameToAttributesMap[
                                                    value];
                                            selectedPipelineId =
                                                selectedPipelineAttributes[
                                                    'pipelineId'];
                                            isAIAnswer =
                                                selectedPipelineAttributes[
                                                    'aiAnswerPerm'];

                                            currentPage.value = 1;
                                            pageSize.value = 10;
                                            AIcurrentPage.value = 1;
                                            AIpageSize.value = 10;

                                            BlocProvider.of<PlutotableBloc>(
                                                    context)
                                                .add(
                                              FetchTableDataEvent(
                                                  selectedDate: selectedDate,
                                                  selectedPipeline:
                                                      selectedPipelineId,
                                                  page: currentPage.value,
                                                  pageSize: pageSize.value),
                                            );

                                            BlocProvider.of<DashboardBloc>(
                                                    context)
                                                .add(FetchDashboardDataEvent(
                                                    selectedDate: selectedDate,
                                                    selectedPipeline:
                                                        selectedPipelineId ??
                                                            ""));

                                            if(isAIAnswer){
                                                BlocProvider.of<AiQueryAnswerBloc>(
                                                    context)
                                                .add(
                                              FetchAiQueryAnswerEvent(
                                                  selectedDate: selectedDate,
                                                  selectedPipeline:
                                                      selectedPipelineId,
                                                  selectedClassification:
                                                      isAnswer,
                                                  page: AIcurrentPage.value,
                                                  pageSize: AIpageSize.value),
                                            );
                                            BlocProvider.of<AiQueryChartBloc>(
                                                    context)
                                                .add(FetchAiQueryChartData(
                                                    selectedDate: selectedDate,
                                                    selectedPipeline:
                                                        selectedPipelineId ??
                                                            ""));
                                            }
                                          
                                            
                                              BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(
                                                        GetValidationCountEvent(
                                                            selectedDate:
                                                                selectedDate,
                                                            selectedPipeline:
                                                                selectedPipelineId ??
                                                                    ""));
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(
                                                        GetValidationByCountEvent(
                                                            selectedDate:
                                                                selectedDate,
                                                            selectedPipeline:
                                                                selectedPipelineId ??
                                                                    ""));

                                            BlocProvider.of<
                                                        DashboardPipelineBloc>(
                                                    context,
                                                    listen: false)
                                                .add(
                                              UpdateSelectedPipelineEvent(
                                                selectedDate: selectedDate,
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
                              UIHelpers.verticalSpaceTiny,
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
                                        validationCount: state
                                            .getValidationCountAttributeModel,
                                        data: state.pieChartData,
                                        validationByCount: state
                                            .getValidationByCountAttributeModel,
                                        userSettingsData: state.getUserSettingsAttributeModel,
                                        isAIQuery: false);
                                  } else if (state is DashboardDataError) {
                                    return FailureWidget(
                                        width: UIHelpers.screenWidth(context) *
                                            0.19,
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.75,
                                        color: SupportBotColors.gray);
                                  } else if (state is DashboardDataEmpty) {
                                    return SizedBox(
                                        width: UIHelpers.screenWidth(context) *
                                            0.19,
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.75,
                                        child: Center(child: const EmptyWidget()));
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
                                    return FailureWidget(
                                        width: UIHelpers.screenWidth(context) *
                                            0.19,
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.05,
                                        color: SupportBotColors.gray);
                                  } else if (state
                                      is DashboardPipelineSuccess) {
                                    pipeline =
                                        state.selectedPipelineValue ?? "";
                                    Map<String, dynamic>
                                        pipelineNameToAttributesMap = {
                                      for (var item in state
                                              .dashboardPipelineAttributeModel
                                              ?.data ??
                                          [])
                                        item.pipelineName: {
                                          'pipelineId': item.pipelineId,
                                          'aiAnswerPerm': item.aiAnswerPerm,
                                        },
                                    };
                                    List<String?> dropdownItems =
                                        pipelineNameToAttributesMap.keys
                                            .toList();
                                    return SizedBox(
                                      width: UIHelpers.screenWidth(context),
                                      child:
                                          DashboardPipelineFilterDropdownWidget(
                                        selectedValue: pipeline,
                                        items: dropdownItems,
                                        onChanged: (String? value) {
                                          if (value != null) {
                                            var selectedPipelineAttributes =
                                                pipelineNameToAttributesMap[
                                                    value];
                                            selectedPipelineId =
                                                selectedPipelineAttributes[
                                                    'pipelineId'];
                                            isAIAnswer =
                                                selectedPipelineAttributes[
                                                    'aiAnswerPerm'];

                                            currentPage.value = 1;
                                            pageSize.value = 10;
                                            AIcurrentPage.value = 1;
                                            AIpageSize.value = 10;

                                            if(isAIAnswer){
                                               BlocProvider.of<AiQueryAnswerBloc>(
                                                    context)
                                                .add(
                                              FetchAiQueryAnswerEvent(
                                                  selectedDate: selectedDate,
                                                  selectedPipeline:
                                                      selectedPipelineId,
                                                  selectedClassification:
                                                      isAnswer,
                                                  page: AIcurrentPage.value,
                                                  pageSize: AIpageSize.value),
                                            );
                                            BlocProvider.of<AiQueryChartBloc>(
                                                    context)
                                                .add(FetchAiQueryChartData(
                                                    selectedDate: selectedDate,
                                                    selectedPipeline:
                                                        selectedPipelineId ??
                                                            ""));
                                            }
                                           

                                            BlocProvider.of<PlutotableBloc>(
                                                    context)
                                                .add(
                                              FetchTableDataEvent(
                                                  selectedDate: selectedDate,
                                                  selectedPipeline:
                                                      selectedPipelineId,
                                                  page: currentPage.value,
                                                  pageSize: pageSize.value),
                                            );

                                            BlocProvider.of<DashboardBloc>(
                                                    context)
                                                .add(FetchDashboardDataEvent(
                                                    selectedDate: selectedDate,
                                                    selectedPipeline:
                                                        selectedPipelineId ??
                                                            ""));

                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(
                                                        GetValidationCountEvent(
                                                            selectedDate:
                                                                selectedDate,
                                                            selectedPipeline:
                                                                selectedPipelineId ??
                                                                    ""));
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(
                                                        GetValidationByCountEvent(
                                                            selectedDate:
                                                                selectedDate,
                                                            selectedPipeline:
                                                                selectedPipelineId ??
                                                                    ""));

                                            BlocProvider.of<
                                                        DashboardPipelineBloc>(
                                                    context,
                                                    listen: false)
                                                .add(
                                              UpdateSelectedPipelineEvent(
                                                selectedDate: selectedDate,
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
                                    if (isAIAnswer) {
                                      return PieChartWidget(
                                          data: state.pieChartData,
                                          isAIQuery: true);
                                    }
                                    return SizedBox(
                                        width: UIHelpers.screenWidth(context) *
                                            0.19,
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.75,
                                        child: Center(
                                            child: Text(
                                          'AI Answer is not enable for this pipeline',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        )));
                                  } else if (state is AiQueryChartFailure) {
                                    return FailureWidget(
                                        width: UIHelpers.screenWidth(context) *
                                            0.19,
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.75,
                                        color: SupportBotColors.gray);
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
    return months[month - 1];
  }

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
    return DateTime(2024, months[month]!);
  }
}


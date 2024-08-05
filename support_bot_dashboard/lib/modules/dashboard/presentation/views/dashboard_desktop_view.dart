import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/header/nav_bar.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/custom_button_bloc/custombutton_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/revert_classification/revert_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_ai_query_answer_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/count_container.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/date_selection_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pie_chart_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pluto_table_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_button.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_filter_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_month_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/export_button.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class DashboardDesktopView extends StatelessWidget {
  const DashboardDesktopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<DashboardBloc>()
            ..add(FetchDashboardDataEvent(DateTime.now(), null, null)),
        ),
        BlocProvider(
          create: (context) => serviceLocator<PlutotableBloc>()
            ..add(
              FetchTableDataEvent(
                selectedDate: DateTime.now(),
                selectedMonth: DateTime(2024, 1),
              ),
            ),
        ),
        BlocProvider(
          create: (context) => serviceLocator<CustombuttonBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<RevertClassificationBloc>(),
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            NavBar(
              showPopArrow: false,
              navigateTo: () {},
              text: "",
            ),
            Row(
              children: [
                Flexible(
                  flex: 8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: BlocBuilder<DashboardBloc, DashboardState>(
                          builder: (context, state) {
                            if (state is DashboardDataLoading) {
                              return Center(
                                child: LoadingWidget(
                                  width: UIHelpers.screenWidth(context) * 0.75,
                                  height: UIHelpers.screenHeight(context) * 0.2,
                                  radius: 8,
                                ),
                              );
                            } else if (state is DashboardDataSuccess) {
                              num totalCount = (state
                                          .pieChartData?.spamMarketing ??
                                      0) +
                                  (state.pieChartData?.noActionRequired ?? 0) +
                                  (state.pieChartData?.genuineQuery ?? 0) +
                                  (state.pieChartData?.acknowledgement ?? 0);
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CountContainer(
                                    text: S.of(context).spam,
                                    icon: 'assets/icons/Spam.svg',
                                    count: state.pieChartData?.spamMarketing
                                            .toString() ??
                                        '0',
                                  ),
                                  CountContainer(
                                    text: S.of(context).noActionRequired,
                                    icon: 'assets/icons/NotSpam.svg',
                                    count: state.pieChartData?.noActionRequired
                                            .toString() ??
                                        '0',
                                  ),
                                  CountContainer(
                                    text: S.of(context).genuineQuery,
                                    icon: 'assets/icons/genuine.svg',
                                    count: state.pieChartData?.genuineQuery
                                            .toString() ??
                                        '0',
                                  ),
                                  CountContainer(
                                    text: S.of(context).acknowledgementRequired,
                                    icon: 'assets/icons/acknowledgement.svg',
                                    count: state.pieChartData?.acknowledgement
                                            .toString() ??
                                        '0',
                                  ),
                                  CountContainer(
                                    text: S.of(context).total,
                                    icon: 'assets/icons/TotalTicket.svg',
                                    count: totalCount.toString(),
                                  ),
                                ],
                              );
                            } else if (state is DashboardDataError) {
                              return const Center(child: EmptyWidget());
                            } else {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CountContainer(
                                    text: S.of(context).spam,
                                    icon: 'assets/icons/Spam.svg',
                                    count: '0',
                                  ),
                                  CountContainer(
                                    text: S.of(context).noActionRequired,
                                    icon: 'assets/icons/NotSpam.svg',
                                    count: '0',
                                  ),
                                  CountContainer(
                                    text: S.of(context).genuineQuery,
                                    icon: 'assets/icons/genuine.svg',
                                    count: '0',
                                  ),
                                  CountContainer(
                                    text: S.of(context).acknowledgementRequired,
                                    icon: 'assets/icons/acknowledgement.svg',
                                    count: '0',
                                  ),
                                  CountContainer(
                                    text: S.of(context).total,
                                    icon: 'assets/icons/TotalTicket.svg',
                                    count: '0',
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
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

                          return Row(
                            children: [
                              CustomButton(
                                text: S.of(context).ticketClassification,
                                isSelected: selectedButtonText ==
                                    'Ticket Classification',
                                onPressed: () {
                                  BlocProvider.of<CustombuttonBloc>(context)
                                      .add(SelectButtonEvent(
                                          'Ticket Classification'));
                                },
                              ),
                              CustomButton(
                                text: S.of(context).aiQueryAnswer,
                                isSelected:
                                    selectedButtonText == 'AI Query Answer',
                                onPressed: () {
                                  BlocProvider.of<CustombuttonBloc>(context)
                                      .add(
                                          SelectButtonEvent('AI Query Answer'));
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              BlocBuilder<DashboardBloc, DashboardState>(
                                builder: (context, state) {
                                  DateTime selectedDate = DateTime.now();
                                  if (state is DashboardDataSuccess) {
                                    selectedDate = state.selectedDate;
                                  } else if (state is DashboardDataError) {
                                    selectedDate = state.selectedDate;
                                  }
                                  return DateSelectionWidget(
                                    selectedDate: selectedDate,
                                    onChanged: (newDate) {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .add(
                                              UpdateSelectedDateEvent(newDate));
                                      BlocProvider.of<PlutotableBloc>(context)
                                          .add(SelectDateEvent(
                                              selectedDate: newDate));
                                    },
                                    label: S.of(context).day,
                                    isInteractive: true,
                                  );
                                },
                              ),
                              BlocBuilder<DashboardBloc, DashboardState>(
                                builder: (context, state) {
                                  DateTime selectMonth = DateTime(2024, 1);
                                  if (state is DashboardDataSuccess) {
                                    selectMonth = state.selectedMonth;
                                  } else if (state is DashboardDataError) {
                                    selectMonth = state.selectedMonth;
                                  }
                                  return CustomMonthDropdown(
                                    selectedValue: selectMonth,
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
                                    onChanged: (DateTime? value) {
                                      if (value != null) {
                                        BlocProvider.of<DashboardBloc>(context)
                                            .add(UpdateSelectedMonthEvent(
                                                value));
                                        BlocProvider.of<PlutotableBloc>(context)
                                            .add(SelectMonthEvent(
                                                selectedMonth: value));
                                      }
                                    },
                                    label: S.of(context).month,
                                  );
                                },
                              ),
                              BlocBuilder<PlutotableBloc, PlutotableState>(
                                builder: (context, state) {
                                  if (state is FetchTableDataSuccess) {
                                    DateTime selectedDate = state.selectedDate;
                                    DateTime selectedMonth =
                                        state.selectedMonth;

                                    return CustomFilterDropdown(
                                      selectedValue:
                                          state.selectedClassification,
                                      items: const [
                                            'Select',
                                            'Spam/Marketing',
                                            'No Action Required',
                                            'Genuine Query',
                                            'Acknowledgement Required'
                                          ],
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          BlocProvider.of<PlutotableBloc>(
                                                  context,
                                                  listen: false)
                                              .add(
                                            FilterClassificationEvent(
                                              state.tableData.items,
                                              selectedDate,
                                              selectedMonth,
                                              value,
                                            ),
                                          );
                                        }
                                      },
                                      label:  S.of(context).classification,
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              BlocBuilder<PlutotableBloc, PlutotableState>(
                                builder: (context, state) {
                                  if (state is FetchTableDataSuccess) {
                                    return CustomFilterDropdown(
                                        selectedValue: state.selectedValidation,
                                        items: const [
                                          'Select',
                                          'correct',
                                          'incorrect',
                                        ],
                                        onChanged: (String? value) {
                                          if (value != null) {
                                            BlocProvider.of<PlutotableBloc>(
                                                    context,
                                                    listen: false)
                                                .add(FilterValidationEvent(
                                                    value,
                                                    state.tableData.items,
                                                    state.selectedDate,
                                                    state.selectedMonth,
                                                    state
                                                        .selectedClassification));
                                          }
                                        },
                                        label:  S.of(context).validation);
                                  } else {
                                    return Container();
                                  }
                                },
                              )
                            ],
                          ),
                           Tooltip(
                              message:  S.of(context).export,
                              child: const ExportButton(
                                  icon: 'assets/icons/Export.svg')),
                        ],
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
                                          selectedMonth: state.selectedMonth,
                                        ),
                                      );
                                } else if (state is UpdateValidationSuccess ||
                                    state is UpdateValidationError) {
                                  context.read<PlutotableBloc>().add(
                                        FetchTableDataEvent(
                                          selectedDate: DateTime.now(),
                                          selectedMonth: DateTime(2024, 1),
                                        ),
                                      );
                                  Navigator.of(context).pop();
                                }
                              },
                              builder: (context, state) {
                                if (state is UpdateValidationLoading) {
                                  return Center(
                                    child: LoadingWidget(
                                      height: UIHelpers.screenHeight(context) *
                                          0.43,
                                      width:
                                          UIHelpers.screenWidth(context) * 0.75,
                                      radius: 8,
                                    ),
                                  );
                                }
                                if (state is FetchTableDataLoading) {
                                  return Center(
                                      child: LoadingWidget(
                                    height:
                                        UIHelpers.screenHeight(context) * 0.43,
                                    width:
                                        UIHelpers.screenWidth(context) * 0.75,
                                    radius: 8,
                                  ));
                                } else if (state is FetchTableDataEmpty) {
                                  return SizedBox(
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.5,
                                        child: const EmptyWidget());
                                } else if (state is FetchTableDataSuccess) {
                                  if (state.noDataAvailable) {
                                    return SizedBox(
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.5,
                                        child: const EmptyWidget());
                                  }
                                  return PlutoTableWidget(
                                    tableData: state.tableData,
                                    selectedDate: state.selectedDate,
                                    selectedMonth: state.selectedMonth,
                                  );
                                } else if (state is FetchTableDataError) {
                                  return SizedBox(
                                        height:
                                            UIHelpers.screenHeight(context) *
                                                0.5,
                                        child: const EmptyWidget());
                                } else {
                                  return Container();
                                }
                              },
                            );
                          } else {
                            return const AIQueryAnswerWidget();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      if (state is DashboardDataLoading) {
                        return Center(
                          child: LoadingWidget(
                            width: UIHelpers.screenWidth(context) * 0.2,
                            height: UIHelpers.screenHeight(context) * 0.85,
                            radius: 8,
                          ),
                        );
                      } else if (state is DashboardDataSuccess) {
                        return PieChartWidget(data: state.pieChartData);
                      } else if (state is DashboardDataError) {
                        return const Center(child: EmptyWidget());
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

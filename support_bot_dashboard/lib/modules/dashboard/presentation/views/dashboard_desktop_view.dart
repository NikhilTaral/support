
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/custom_button_bloc/custombutton_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/count_container.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/date_selection_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pie_chart_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pluto_table_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_button.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_dropdown.dart';
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
          create: (context) => DashboardBloc()..add(LoadPiechartData(DateTime.now(), null, null)),
        ),
        BlocProvider(
          create: (context) => PlutotableBloc()..add(FetchTableDataEvent(selectedDate: DateTime.now(), selectedMonth: DateTime(2024, 1))),
        ),
         BlocProvider(
          create: (context) => CustombuttonBloc(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      height: UIHelpers.screenHeight(context)/11,
                      child: BlocBuilder<DashboardBloc, DashboardState>(
                        builder: (context, state) {
                          if (state is FetchCountDataLoading) {
                            return  Center(child: LoadingWidget(width: UIHelpers.screenWidth(context), height: UIHelpers.screenHeight(context)/11,));
                          } else if (state is DashboardDataSuccess) {
                            num totalCount = (state.countData?.spamMarketing ?? 0) +
                                (state.countData?.noActionRequired ?? 0) +
                                (state.countData?.genuineQuery ?? 0);
                            return Row(
                              children: [
                                CountContainer(
                                  text: 'Spam',
                                  icon: 'assets/icons/Spam.svg',
                                  count: state.countData?.spamMarketing.toString() ?? '0',
                                ),
                                CountContainer(
                                  text: 'No Action Required',
                                  icon: 'assets/icons/NotSpam.svg',
                                  count: state.countData?.noActionRequired.toString() ?? '0',
                                ),
                                CountContainer(
                                  text: 'Genuine Query',
                                  icon: 'assets/icons/genuine.svg',
                                  count: state.countData?.genuineQuery.toString() ?? '0',
                                ),
                                CountContainer(
                                  text: 'Total',
                                  icon: 'assets/icons/TotalTicket.svg',
                                  count: totalCount.toString(),
                                ),
                              ],
                            );
                          } else if (state is FetchCountDataError) {
                            return const Center(child: EmptyWidget());
                          } else {
                            return const Row(
                              children: [
                                  CountContainer(
                                  text: 'Spam',
                                  icon: 'assets/icons/Spam.svg',
                                  count: '0',
                                ),
                                CountContainer(
                                  text: 'No Action Required',
                                  icon: 'assets/icons/NotSpam.svg',
                                  count: '0',
                                ),
                                CountContainer(
                                  text: 'Genuine Query',
                                  icon: 'assets/icons/genuine.svg',
                                  count: '0',
                                ),
                                CountContainer(
                                  text: 'Total',
                                  icon: 'assets/icons/TotalTicket.svg',
                                  count: '0',
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  BlocBuilder<CustombuttonBloc, CustombuttonState>(
                    builder: (context, state) {
                      String selectedButtonText = '';
                      if (state is ButtonSelectedState) {
                        selectedButtonText = state.selectedButtonText;
                      }

                      if (state is CustomButtonInitial && state.selectedButtonText == 'Ticket Classification') {
                        selectedButtonText = state.selectedButtonText;
                      }

                      return Row(
                        children: [
                          CustomElevatedButton(
                            text: 'Ticket Classification',
                            isSelected: selectedButtonText == 'Ticket Classification',
                            onPressed: () {
                              BlocProvider.of<CustombuttonBloc>(context).add( SelectButtonEvent('Ticket Classification'));
                            },
                          ),
                          CustomElevatedButton(
                            text: 'AI Query Answer',
                            isSelected: selectedButtonText == 'AI Query Answer',
                            onPressed: () {
                              BlocProvider.of<CustombuttonBloc>(context).add( SelectButtonEvent('AI Query Answer'));
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            BlocBuilder<DashboardBloc, DashboardState>(
                              builder: (context, state) {
                                DateTime selectedDate = DateTime.now();
                                if (state is DashboardDataSuccess) {
                                  selectedDate = state.selectedDate;
                                }
                                return DateSelectionWidget(
                                  selectedDate: selectedDate,
                                  onChanged: (newDate) {
                                    BlocProvider.of<DashboardBloc>(context).add(UpdateSelectedDateEvent(newDate));
                                    BlocProvider.of<PlutotableBloc>(context).add(SelectDateEvent(selectedDate: newDate));
                                  },
                                  label: 'Day',
                                  isInteractive: true,
                                );
                              },
                            ),
                            UIHelpers.horizontalSpaceSmall,
                            BlocBuilder<DashboardBloc, DashboardState>(
                              builder: (context, state) {
                                DateTime selectMonth = DateTime(2024, 1);
                                if (state is DashboardDataSuccess) {
                                  selectMonth = state.selectedMonth;
                                }
                                return CustomDropdown(
                                  selectedValue: selectMonth,
                                  items: const [
                                    'January', 'February', 'March', 'April', 'May', 'June',
                                    'July', 'August', 'September', 'October', 'November', 'December'
                                  ],
                                  onChanged: (DateTime? value) {
                                    if (value != null) {
                                      BlocProvider.of<DashboardBloc>(context).add(UpdateSelectedMonthEvent(value));
                                      BlocProvider.of<PlutotableBloc>(context).add(SelectMonthEvent(selectedMonth: value));
                                    }
                                  },
                                  label: 'Month',
                                );
                              },
                            ),
                            BlocBuilder<PlutotableBloc, PlutotableState>(
                              builder: (context, state) {
                                if (state is FetchTableDataSuccess) {
                                  List<TableItem> initialTableData = [];
                                  DateTime selectedDate = DateTime.now();
                                  DateTime selectedMonth = DateTime(2024 - 01);
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
                                                initialTableData,
                                                selectedDate,
                                                selectedMonth,
                                                value),
                                          );
                                        }
                                      },
                                      label: 'Classification');
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
                                                  state.selectedMonth, state.selectedClassification));
                                        }
                                      },
                                      label: 'Validation');
                                } else {
                                  return Container();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Tooltip(message:'download csv file',  child: ExportButton(icon: 'assets/icons/Export.svg')),
                    ],
                  ),
                  BlocBuilder<CustombuttonBloc, CustombuttonState>(
                    builder: (context, state) {
                      if (state is ButtonSelectedState && state.selectedButtonText == 'Ticket Classification') {
                        return Expanded(
                          flex: 7,
                          child: BlocBuilder<PlutotableBloc, PlutotableState>(
                            builder: (context, state) {
                              if (state is FetchTableDataLoading) {
                                return Center(child: LoadingWidget(height: UIHelpers.screenHeight(context)/2,width: UIHelpers.screenWidth(context)/1.5,radius: 8,));
                              } else if (state is FetchTableDataSuccess) {
                                return PlutoTableWidget(tableData: state.tableData);
                              } else if (state is FetchTableDataError) {
                                return const Center(child: EmptyWidget());
                              } else {
                                return Container();
                              }
                            },
                          ),
                        );
                      } else if (state is CustomButtonInitial ) {
                        return Expanded(
                          flex: 7,
                          child: BlocBuilder<PlutotableBloc, PlutotableState>(
                            builder: (context, state) {
                              if (state is FetchTableDataLoading) {
                                return Center(child: LoadingWidget(height: UIHelpers.screenHeight(context)/2,width: UIHelpers.screenWidth(context)/1.5,radius: 8,));
                              } else if (state is FetchTableDataSuccess) {
                                return PlutoTableWidget(tableData: state.tableData);
                              } else if (state is FetchTableDataError) {
                                return const Center(child: EmptyWidget());
                              } else {
                                return Container();
                              }
                            },
                          ),
                        );
                      } else {
                        return Container(
                          height: UIHelpers.screenHeight(context)/2,
                          child: Center(
                            child: Text('No Data available'),
                          ),
                        );
                      }
                    },
                  ),
               
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is PiechartLoading) {
                    return Center(child: LoadingWidget(width: UIHelpers.screenWidth(context)/4,height: UIHelpers.screenHeight(context)/1.3,radius: 8,));
                  } else if (state is DashboardDataSuccess) {
                    return PieChartWidget(data: state.pieChartData);
                  } else if (state is PieChartError) {
                    return const Center(child: EmptyWidget());
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

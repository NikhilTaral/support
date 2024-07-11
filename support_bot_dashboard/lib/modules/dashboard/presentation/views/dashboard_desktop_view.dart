
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/count_container.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/date_selection_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pie_chart_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pluto_table_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_button.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/export_button.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';


class DashboardDesktopView extends StatelessWidget {
  const DashboardDesktopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DashboardBloc(),
        ),
        BlocProvider(
          create: (context) => PlutotableBloc()..add(FetchTableDataEvent(selectedDate: DateTime.now(), selectedMonth: DateTime(2024, 1))),
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
                            return const Center(child: CircularProgressIndicator());
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
                            return const Center(child: Text('No Data Available'));
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
                  const Row(
                    children: [
                      CustomElevatedButton(text: 'Ticket Classification', isSelected: true),
                      CustomElevatedButton(text: 'AI Query Answer'),
                    ],
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
                          ],
                        ),
                      ),
                      const Spacer(),
                      const ExportButton(icon: 'assets/icons/Export.svg'),
                    ],
                  ),
                  Expanded(
                    flex: 7,
                    child: BlocBuilder<PlutotableBloc, PlutotableState>(
                      builder: (context, state) {
                        if (state is FetchTableDataLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is FetchTableDataSuccess) {
                          return PlutoTableWidget(tableData: state.tableData);
                        } else if (state is FetchTableDataError) {
                          return const Center(child: Text('No Data Available'));
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is PiechartLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DashboardDataSuccess) {
                    return PieChartWidget(data: state.pieChartData);
                  } else if (state is PieChartError) {
                    return const Center(child: Text('No Data Available'));
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

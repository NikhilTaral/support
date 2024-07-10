import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/count_container.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/date_selection_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pie_chart_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pluto_table_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_button.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/export_button.dart';

class DashboardDesktopView extends StatelessWidget {
  const DashboardDesktopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: 
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 11,
                        child: const Row(
                          children: [
                            CountContainer(
                              text: 'Spam',
                              icon: 'assets/icons/Spam.svg',
                              count: '8',
                            ),
                            CountContainer(
                              text: 'No Action Required',
                              icon: 'assets/icons/NotSpam.svg',
                              count: '8',
                            ),
                            CountContainer(
                              text: 'Genuine Query',
                              icon: 'assets/icons/genuine.svg',
                              count: '8',
                            ),
                            CountContainer(
                              text: 'Total',
                              icon: 'assets/icons/TotalTicket.svg',
                              count: '8',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Row(
                      children: [
                        CustomElevatedButton(text: 'Ticket Classification'),
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
                                  if (state is PiechartDataSuccess) {
                                    print("UI: ${state.selectedDate}");
                                    selectedDate = state.selectedDate;
                                  }
                                  return DateSelectionWidget(
                                    selectedDate: state is PiechartDataSuccess ? state.selectedDate : DateTime.now(),
                                    onChanged: (newDate) {
                                      BlocProvider.of<DashboardBloc>(context).add(UpdateSelectedDateEvent(newDate));
                                      print("$state");
                                    },
                                    label: 'Day',
                                    isInteractive: true,
                                  );
                                },
                              ),
                              const SizedBox(width: 10),
                              BlocBuilder<DashboardBloc, DashboardState>(
                                 builder: (context, state) {
                                  DateTime selectMonth = DateTime(2024, 1);
                                  if (state is PiechartDataSuccess) {
                                    print("UI: ${state.selectedMonth}");
                                    selectMonth = state.selectedMonth;
                                  }
                                  return CustomDropdown(
                                  selectedValue: selectMonth,
                                  items: const [
                                    'January', 'February', 'March', 'April', 'May', 'June',
                                    'July', 'August', 'September', 'October', 'November', 'December'
                                  ],
                                  onChanged: (DateTime? value) {
                                 BlocProvider.of<DashboardBloc>(context).add(UpdateSelectedMonthEvent(value ?? DateTime(2024, 1)));
                                  },
                                  label: 'Month',
                                );
                                 }
                                
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        // CustomDropdown(
                        //   selectedValue: 'Spam',
                        //   items: const [
                        //     'Spam', 'Genuine Query', 'No Action'
                        //   ],
                        //   onChanged: (String? value) {
                        //     print('Selected value: $value');
                        //   },
                        //   label: 'Classification',
                        // ),
                        const ExportButton(icon: 'assets/icons/Export.svg'),
                      ],
                    ),
                    // Expanded(
                    //   flex: 4,
                    //   child: BlocBuilder<DashboardBloc, DashboardState>(
                    //     builder: (context, state) {
                    //       if (state is DashboardDataLoading) {
                    //         return const Center(child: CircularProgressIndicator());
                    //       } else if (state is DashboardDataSuccess) {
                    //         return const PlutoTableWidget();
                    //       } else if (state is DashboardDataFailure) {
                    //         return Center(child: Text('Error: ${state.errorMsg}'));
                    //       } else {
                    //         return Container();
                    //       }
                    //     },
                    //   ),
                    // ),
                      Expanded(
                      flex: 7,
                      child: BlocProvider(
                        create: (context) => DashboardBloc()..add(FetchTableDataEvent()),
                        child: const PlutoTableWidget(),
                      ),
                    ),
                  ]
                ),
              ),
              Expanded(
                flex: 3,
                child: BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state is PiechartLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PiechartDataSuccess) {
                      return PieChartWidget(data: state.data);
                    } else if (state is PieChartError) {
                      return Center(child: Text('No Data Available'));
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

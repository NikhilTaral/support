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
                        child: BlocBuilder<DashboardBloc,DashboardState>(
                          builder: (context, state) {
                              if (state is FetchCountDataLoading) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (state is DashboardDataSuccess) {
                                  num totalCount = (state.countData?.spamMarketing ?? 0) +
                                                   (state.countData?.noActionRequired ?? 0) +
                                                   (state.countData?.genuineQuery ?? 0);
                                  return  Row(
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
                                return Container();
                              }
                          },
                        
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
                                  if (state is DashboardDataSuccess) {
                                    selectedDate = state.selectedDate;
                                  }
                                  return DateSelectionWidget(
                                    selectedDate: state is DashboardDataSuccess ? state.selectedDate : DateTime.now(),
                                    onChanged: (newDate) {
                                      BlocProvider.of<DashboardBloc>(context).add(UpdateSelectedDateEvent(newDate));
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

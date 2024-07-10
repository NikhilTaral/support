import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/date_selection_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pie_chart_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pluto_table_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/count_container.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_button.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/export_button.dart';

class DashboardDesktopView extends StatelessWidget {
  const DashboardDesktopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 11,
                    child:const Row(
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
                        )
                      ],
                    ),
                  ),
                ),
              
                 const Row(
                    children: [
                       CustomElevatedButton(text: 'Ticket Classification' , isSelected: true,),
                       CustomElevatedButton(text: 'AI Query Answer')
               
                    ],
                  ),
                
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      DateSelectionWidget(
                        selectedValue: 'Select Date',
                        onChanged: (newValue) {
                          // Handle onChanged if needed
                        },
                        label: 'Day',
                        selectedDate: DateTime.now(),
                        isInteractive: true,
                      ),
                      const SizedBox(width: 10), // Space between DateSelectionWidget and CustomDropdown
                      CustomDropdown(
                        selectedValue: 'January', // Set initially selected item
                        items: const [
                          'January', 'February', 'March', 'April', 'May', 'June',
                          'July', 'August', 'September', 'October', 'November', 'December'
                        ], // List of items
                        onChanged: (String? value) {
                          print('Selected value: $value');
                        },
                        label: 'Month',
                      ),
                    ],
                  ),
                ),
                const Spacer(), // Spacer to evenly distribute space between left and right sections
                CustomDropdown(
                  selectedValue: 'Spam', // Set initially selected item
                  items: const [
                    'Spam', 'Genuine Query', 'No Action'
                  ], // List of items
                  onChanged: (String? value) {
                    print('Selected value: $value');
                  },
                  label: 'Classification',
                ),   // Space between DateSelectionWidget and CustomDropdown
                const ExportButton(icon: 'assets/icons/ExportIcon.svg'),
              ],
            ),
                Expanded(
                  flex: 7,
                    child: BlocProvider(
                      create: (context) => DashboardBloc()..add(FetchTableDataEvent()),
                      child: const PlutoTableWidget(),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: BlocProvider(
              create: (context) => DashboardBloc()..add(LoadPiechartData(DateTime.now())),
              child: const PieChartWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

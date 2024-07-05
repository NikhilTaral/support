import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:intl/intl.dart';

class DateSelectionWidget extends StatelessWidget {
  const DateSelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        String selectedTimePeriod = 'Day';

        if (state is TimePeriodSelectionState) {
          selectedTimePeriod = state.selectedTimePeriod;
        }

        return Padding(
          padding: const EdgeInsets.only(left: 37),
          child: Row(
            children: [
              DropdownButton<String>(
                  value: selectedTimePeriod,
                  items: ['Day', 'Week', 'Month', 'Year'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      context
                          .read<DashboardBloc>()
                          .add(SelectTimePeriodEvent(newValue));
                      if (newValue == 'Day') {
                        DateTime selectedDate = DateTime.now();
                        context
                            .read<DashboardBloc>()
                            .add(LoadPiechartData(selectedDate));
                      }
                    }
                  }),
              const SizedBox(width: 20),
              if (selectedTimePeriod == 'Day') ...[
                DateContainer(DateTime.now(), 'Current Date'),
              ] else if (selectedTimePeriod == 'Week') ...[
                DateContainer(
                  DateTime.now()
                      .subtract(Duration(days: DateTime.now().weekday - 1)),
                  'Start Date',
                ),
                const SizedBox(width: 20),
                DateContainer(
                  DateTime.now()
                      .add(Duration(days: 7 - DateTime.now().weekday)),
                  'End Date',
                ),
              ] else if (selectedTimePeriod == 'Month') ...[
                MonthDropdown(context),
              ],
              const SizedBox(width: 20),
            ],
          ),
        );
      },
    );
  }

  Widget DateContainer(DateTime date, String label) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.grey[200],
      child: Text('$label: $formattedDate'),
    );
  }

  Widget MonthDropdown(BuildContext context) {
    List<String> months = [
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

    return DropdownButton<String>(
      hint: const Text('Select Month'),
      items: months.map((String month) {
        return DropdownMenuItem<String>(
          value: month,
          child: Text(month),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          print('Selected Month: $newValue');
        }
      },
    );
  }
}

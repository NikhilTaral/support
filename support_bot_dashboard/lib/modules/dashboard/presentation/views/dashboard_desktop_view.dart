import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pie_chart_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pluto_table_widget.dart';

class DashboardDesktopView extends StatelessWidget {
  const DashboardDesktopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: const Text('Date'),
            ),
          ),
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: MediaQuery.of(context).size.height / 1.21,
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black),
                    // ),
                    child: BlocProvider(
                      create: (context) => DashboardBloc()
                        ..add(
                          LoadPiechartData(),
                        ),
                      child: const PieChartWidget(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: BlocProvider(
                    create: (context) => DashboardBloc()
                      ..add(
                        FetchDataEvent(),
                      ),
                    child: const PlutoTableWidget(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> blueShades = [
      Colors.blue.shade100,
      Colors.blue.shade400,
      Colors.blue.shade700,
    ];
    double radius = MediaQuery.of(context).size.width / 8;
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is PiechartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PiechartDataSuccess) {
          return PieChart(
            PieChartData(
              centerSpaceRadius: 0,
              sectionsSpace: 1,
              sections: List.generate(
                state.data.length,
                (index) => PieChartSectionData(
                  value: state.data[index].value?.toDouble() ?? 0,
                  title: state.data[index].label ?? '',
                  color: blueShades[index % blueShades.length],
                  radius: radius,
                ),
              ),
            ),
          );
        } else if (state is PieChartError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';

class ChartData {
  final String label;
  final double? value;
  final double? percentage;

  ChartData({required this.label, this.value, this.percentage});
}

class FlCircularChart extends StatelessWidget {
  final DashboardDataModel dashboardDataModel;

  FlCircularChart({super.key, required this.dashboardDataModel});

  late final List<ChartData> chartData = [
    ChartData(
        label: 'Genuine Query',
        percentage:
            dashboardDataModel.pieChartData?.data?.percentages?.genuineQuery),
    ChartData(
        label: 'No Action Required',
        percentage: dashboardDataModel
            .pieChartData?.data?.percentages?.noActionRequired),
    ChartData(
        label: 'Spam/Marketing',
        percentage:
            dashboardDataModel.pieChartData?.data?.percentages?.spamMarketing),
    ChartData(
        label: 'Acknowledge required',
        percentage: dashboardDataModel
            .pieChartData?.data?.percentages?.acknowledgementRequired),
  ];

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: chartData.map((data) {
          final color = _getColorForLabel(data.label);
          return PieChartSectionData(
            value: data.percentage,
            title: '${data.percentage?.toStringAsFixed(1)}%',
            color: color,
            radius: 120,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
        centerSpaceRadius: 0,
        sectionsSpace: 0,
        startDegreeOffset: 360,
      ),
      swapAnimationCurve: Curves.easeInOutCirc,
      swapAnimationDuration: const Duration(milliseconds: 2000),
    );
  }

  Color _getColorForLabel(String label) {
    switch (label) {
      case 'Genuine Query':
        return  const Color(0xFFB6C5DF);
      case 'No Action Required':
        return const Color(0xFF8099C7);
      case 'Spam/Marketing':
        return SupportBotColors.bluePrimary.shade400;
      case 'Acknowledge required':
        return const Color(0xFFDBE2EF);
      default:
        return Colors.grey;
    }
  }
}

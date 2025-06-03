import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class ChartData {
  final String label;
  final double? value;
  final double? percentage;

  ChartData({required this.label, this.value, this.percentage});
}

class FlCircularChart extends StatelessWidget {
  final DashboardDataModel dashboardDataModel;
  final ValueNotifier<int?> touchedIndexNotifier = ValueNotifier<int?>(null);

  FlCircularChart({super.key, required this.dashboardDataModel});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(label: 'Genuine Query', percentage: dashboardDataModel.pieChartData?.data?.percentages?.genuineQuery),
      ChartData(label: 'No Action Required', percentage: dashboardDataModel.pieChartData?.data?.percentages?.noActionRequired),
      ChartData(label: 'Spam/Marketing', percentage: dashboardDataModel.pieChartData?.data?.percentages?.spamMarketing),
      ChartData(
          label: 'Acknowledgement required',
          percentage: dashboardDataModel.pieChartData?.data?.percentages?.acknowledgementRequired),
    ];

    return ValueListenableBuilder<int?>(
      valueListenable: touchedIndexNotifier,
      builder: (context, touchedIndex, child) {
        return PieChart(
          PieChartData(
            sections: _getSections(chartData, touchedIndex),
            centerSpaceRadius: 0,
            sectionsSpace: 0,
            startDegreeOffset: 360,
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                  touchedIndexNotifier.value = null;
                  return;
                }
                touchedIndexNotifier.value = pieTouchResponse.touchedSection!.touchedSectionIndex;
              },
            ),
          ),
          swapAnimationCurve: Curves.easeInOutCirc,
          swapAnimationDuration: const Duration(milliseconds: 200),
        );
      },
    );
  }

  List<PieChartSectionData> _getSections(List<ChartData> chartData, int? touchedIndex) {
    return List.generate(chartData.length, (index) {
      final data = chartData[index];
      final color = _getColorForLabel(data.label);
      final isTouched = index == touchedIndex;

      return PieChartSectionData(
        value: data.percentage,
        title: isTouched ? '${data.label}\n${data.percentage?.toStringAsFixed(1)}%' : '${data.percentage?.toStringAsFixed(1)}%',
        color: color,
        radius: 120,
        titleStyle: SupportBotTextstyle.mediumHint.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }

  Color _getColorForLabel(String label) {
    switch (label) {
      case 'Genuine Query':
        return const Color(0xFFB6C5DF);
      case 'No Action Required':
        return const Color(0xFF8099C7);
      case 'Spam/Marketing':
        return SupportBotColors.bluePrimary.shade400;
      case 'Acknowledgement required':
        return const Color(0xFFDBE2EF);
      default:
        return Colors.grey;
    }
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class EvaluationData {
  final String timeLabel;
  final double percentage;
  final int totalResponses;

  EvaluationData({
    required this.timeLabel,
    required this.percentage,
    required this.totalResponses,
  });
}

class EvaluationBarChart extends StatelessWidget {
  final List<EvaluationData> evaluationData;

  const EvaluationBarChart({
    Key? key,
    required this.evaluationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceEvenly,
          maxY: 100,
          minY: 0,
          barGroups: List.generate(evaluationData.length, (index) {
            final item = evaluationData[index];

            return BarChartGroupData(
              groupVertically: true,
              x: index,
              barRods: [
                BarChartRodData(
                  toY: 100,
                  color: SupportBotColors.bluePrimary.withOpacity(0.2),
                  width: 20,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  rodStackItems: [
                    BarChartRodStackItem(
                      0,
                      item.percentage,
                      SupportBotColors.bluePrimary.shade400,
                    ),
                  ],
                ),
              ],
            );
          }),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 80,
                interval: 1,
                getTitlesWidget: (double value, TitleMeta meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < evaluationData.length) {
                    return RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        evaluationData[index].timeLabel,
                        style: SupportBotTextstyle.normal.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 10,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      '${value.toInt()}%',
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 10,
          ),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipMargin: -80,
              tooltipHorizontalOffset: -55,
              tooltipPadding: const EdgeInsets.all(7),
              tooltipRoundedRadius: 5,
              getTooltipColor: (group) => SupportBotColors.gray,
              tooltipBorder: const BorderSide(
                color: SupportBotColors.gray,
                width: 2,
              ),
              maxContentWidth: 800,
              direction: TooltipDirection.bottom,
              rotateAngle: 270,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final item = evaluationData[groupIndex];
                return BarTooltipItem(
                  'Total Responses: ${item.totalResponses}\n'
                  'Percentage: ${item.percentage.toStringAsFixed(1)}%',
                  const TextStyle(color: SupportBotColors.black),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

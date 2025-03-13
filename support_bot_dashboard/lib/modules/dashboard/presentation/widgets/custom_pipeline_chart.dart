import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/pipeline_tile_attribute_model.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class CustomPipelineChart extends StatelessWidget {
  final List<AttributeItem>? pipelineData;
  final s = serviceLocator<S>();

  CustomPipelineChart({
    Key? key,
    required this.pipelineData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredData = pipelineData?.skip(1).toList() ?? [];
    final maxTotalTickets = filteredData.map((e) => e.totalTickets ?? 0).fold(
            0,
            (prev, next) =>
                prev.toInt() > next.toInt() ? prev.toInt() : next.toInt()) ??
        0;
    final int numberOfDivisions = maxTotalTickets > 500 ? 15 : 5;
    final intervalValue = (maxTotalTickets / numberOfDivisions).ceilToDouble();
    return RotatedBox(
      quarterTurns: 1,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: filteredData
              .map((e) => e.totalTickets)
              .toList()
              .reduce((curr, next) => (curr ?? 0) > next! ? curr : next)
              ?.toDouble(),
          minY: 0,
          barGroups: List.generate(filteredData.length, (index) {
            final item = filteredData[index];
            return BarChartGroupData(
              groupVertically: true,
              x: index,
              barRods: [
                BarChartRodData(
                  toY: item.totalTickets?.toDouble() ?? 0,
                  color: SupportBotColors.bluePrimary.shade200,
                  width: 20,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  rodStackItems: [
                    BarChartRodStackItem(
                      0,
                      item.validatedTickets?.toDouble() ?? 0,
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
                reservedSize: 210,
                interval: 1,
                getTitlesWidget: (double value, TitleMeta meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < filteredData.length) {
                    return RotatedBox(
                      quarterTurns: -1,
                      child: SizedBox(
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              filteredData[index].pipelineName ?? '',
                              style: SupportBotTextstyle.normal.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
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
                interval: intervalValue,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 100,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0),
                strokeWidth: 1,
                dashArray: [10, 0],
              );
            },
          ),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipPadding: const EdgeInsets.all(2),
              tooltipRoundedRadius: 5,
              getTooltipColor: (group) => SupportBotColors.gray.shade200,
              tooltipBorder: const BorderSide(
                color: SupportBotColors.disablePrimary,
                width: 2,
              ),
              direction: TooltipDirection.bottom,
              rotateAngle: 270,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${s.validatedText}: ${filteredData[groupIndex].validatedTickets?.toInt() ?? 0} / ${s.totalText}: ${filteredData[groupIndex].totalTickets?.toInt() ?? 0}',
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

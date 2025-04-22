import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/pipeline_tile_attribute_model.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
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
    final maxY = (filteredData
                    .map((e) => e.totalTicketsPercentage ?? 0)
                    .fold<double>(
                        0,
                        (prev, curr) =>
                            curr.toDouble() > prev ? curr.toDouble() : prev) /
                10)
            .ceil() *
        10;

    return RotatedBox(
      quarterTurns: 1,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY.toDouble(),
          minY: 0,
          barGroups: List.generate(filteredData.length, (index) {
            final item = filteredData[index];
            return BarChartGroupData(
              groupVertically: true,
              x: index,
              barRods: [
                BarChartRodData(
                  toY: item.totalTicketsPercentage?.toDouble() ?? 0,
                  color: SupportBotColors.bluePrimary.shade200,
                  width: 20,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  rodStackItems: [
                    BarChartRodStackItem(
                      0,
                      item.validatedTicketPercentage?.toDouble() ?? 0,
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
                            CustomToolTip(
                              toolTipDirection: 23,
                              messageWidget: const SizedBox(height: 3),
                              width: 300,
                              messageWidgetHeight: 6,
                              isMobile: false,
                              textStyle: const TextStyle(
                                color: SupportBotColors.black,
                              ),
                              message: filteredData[index].pipelineName ?? '',
                              child: Text(
                                filteredData[index].pipelineName ?? '',
                                style: SupportBotTextstyle.normal.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
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
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 10,
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
              fitInsideVertically: false,
              tooltipMargin: (-80),
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
                return BarTooltipItem(
                  '${s.validatedCountText}: ${filteredData[groupIndex].validatedTickets?.toDouble() ?? 0} \n'
                  '${s.validatedPercentageText}: ${filteredData[groupIndex].validatedTicketPercentage?.toDouble() ?? 0}% \n'
                  '${s.totalCountText}: ${filteredData[groupIndex].totalTickets?.toDouble() ?? 0}',
                  const TextStyle(
                    color: SupportBotColors.black,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

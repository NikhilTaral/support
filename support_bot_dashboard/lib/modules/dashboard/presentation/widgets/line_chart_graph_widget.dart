import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartGraphWidget extends StatelessWidget {
  LineChartGraphWidget({super.key, required this.dashboardDataModel});

  final DashboardDataModel? dashboardDataModel;
  final Map<String, dynamic>? apiResponseData = {};

  Map<String, dynamic> get apiResponse => {
        'counts': dashboardDataModel
                ?.getValidationByCountAttributeModel?.data?.counts ??
            {},
        'percentages': dashboardDataModel
                ?.getValidationByCountAttributeModel?.data?.percentages ??
            {}
      };

  @override
  Widget build(BuildContext context) {
    final counts = apiResponse['counts'] as Map<String, dynamic>? ?? {};

    List<FlSpot> spots = [];
    double index = 1;
    counts.forEach((key, value) {
      spots.add(FlSpot(index, value.toDouble()));
      index++;
    });

    double minY = spots.isNotEmpty
        ? spots.map((e) => e.y).reduce((a, b) => a < b ? a : b)
        : 0;
    double maxY = spots.isNotEmpty
        ? spots.map((e) => e.y).reduce((a, b) => a > b ? a : b)
        : 10;
    double minX = 0;
    double maxX = spots.isNotEmpty
        ? spots.map((e) => e.x).reduce((a, b) => a > b ? a : b) + 1
        : 2;

    double yMargin = (maxY - minY) * 0.1;
    if (yMargin == 0) yMargin = 1;
    minY = (minY - yMargin).clamp(0, double.infinity);
    maxY = maxY + yMargin;

    if (spots.length == 1) {
      minX = 0;
      maxX = 2;
      minY = 0;
      maxY = maxY + 10;
    }

    return SizedBox(
      width: 800,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            getDrawingHorizontalLine: (value) =>
                const FlLine(color: Color(0xFFC8C8C8)),
            getDrawingVerticalLine: (value) =>
                const FlLine(color: Color(0xFFC8C8C8)),
            drawHorizontalLine: true,
            drawVerticalLine: true,
            show: true,
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (maxY / 5).ceilToDouble(),
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 4.0, bottom: 0),
                    child: Text(
                      value.toStringAsFixed(0),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt() - 1;
                  if (index >= 0 && index < counts.keys.length) {
                    String email = counts.keys.elementAt(index);
                    String name = email.replaceAll('.', ' \n');
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        name,
                        style: SupportBotTextstyle.mediumHint.copyWith(),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(color: Colors.grey, width: 1),
              left: BorderSide(color: Colors.grey, width: 1),
              right: BorderSide(color: Colors.transparent, width: 0),
              top: BorderSide(color: Colors.transparent, width: 0),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              barWidth: 2,
              isStepLineChart: false,
              color: SupportBotColors.bluePrimary.shade400,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 5,
                    color: SupportBotColors.bluePrimary.shade400,
                    strokeWidth: 1,
                    strokeColor: Colors.transparent,
                  );
                },
              ),
            ),
          ],
          minX: minX,
          maxX: maxX,
          minY: minY,
          maxY: maxY,
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipBorder: const BorderSide(
                  width: 2, color: SupportBotColors.disablePrimary),
              getTooltipColor: (touchedSpot) => SupportBotColors.gray.shade200,
              tooltipRoundedRadius: 8,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    spot.y.toStringAsFixed(2),
                    SupportBotTextstyle.caption.copyWith(
                      color: SupportBotColors.black,
                    ),
                  );
                }).toList();
              },
            ),
            touchCallback:
                (FlTouchEvent event, LineTouchResponse? touchResponse) {},
            handleBuiltInTouches: true,
          ),
        ),
      ),
    );
  }
}

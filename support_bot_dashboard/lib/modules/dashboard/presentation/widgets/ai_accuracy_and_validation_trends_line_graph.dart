import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class AiAccuracyAndValidationTrendsLineGraph extends StatelessWidget {
  AiAccuracyAndValidationTrendsLineGraph({
    super.key,
    required this.dashboardDataModel,
  });

  final DashboardDataModel? dashboardDataModel;

  List<dynamic> get apiResponse {
    return [
      {
        'aiAccuracy': dashboardDataModel
                ?.aiAccuracyAndValidationTrendsAttributeModel?.data?.items
                ?.map((e) => e.aiAccuracy ?? 0)
                ?.toList() ??
            [],
        'validationPercentage': dashboardDataModel
                ?.aiAccuracyAndValidationTrendsAttributeModel?.data?.items
                ?.map((e) => e.validationPercentage ?? 0)
                ?.toList() ??
            [],
        'date': dashboardDataModel
                ?.aiAccuracyAndValidationTrendsAttributeModel?.data?.items
                ?.map((e) => e.date ?? '')
                ?.toList() ??
            [],
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    final dates = apiResponse.first['date'] as List<String>;
    final aiAccuracyData = apiResponse.first['aiAccuracy'] as List<num>;
    final validationPercentageData =
        apiResponse.first['validationPercentage'] as List<num>;

    List<FlSpot> aiAccuracySpots = [];
    List<FlSpot> validationPercentageSpots = [];

    for (int i = 0; i < aiAccuracyData.length; i++) {
      aiAccuracySpots.add(FlSpot(i.toDouble(), aiAccuracyData[i].toDouble()));
      validationPercentageSpots
          .add(FlSpot(i.toDouble(), validationPercentageData[i].toDouble()));
    }

    final minY = 0;
    final maxY = 100;

    final maxX = dates.isNotEmpty ? dates.length.toDouble() - 1 : 1;
    final minX = 0;
    final yInterval = 10;

    final xInterval = dates.length > 10 ? (dates.length / 7) : 1;

    return SizedBox(
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            getDrawingHorizontalLine: (value) =>
                const FlLine(color: Colors.transparent),
            getDrawingVerticalLine: (value) =>
                const FlLine(color: Colors.transparent),
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
                interval: yInterval.toDouble(),
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
                interval: xInterval.toDouble(),
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < dates.length) {
                    try {
                      final date = DateTime.parse(dates[index]);
                      final formattedDate = DateFormat('MMM dd').format(date);
                      return Container(
                        margin: const EdgeInsets.only(left: 15, right: 25),
                        child: Text(
                          formattedDate,
                          style: SupportBotTextstyle.mediumHint.copyWith(),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } catch (e) {
                      return Text(
                        dates[index],
                        style: SupportBotTextstyle.mediumHint.copyWith(),
                        textAlign: TextAlign.center,
                      );
                    }
                  }
                  return const SizedBox.shrink();
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
              isCurved: true,
              preventCurveOverShooting: true,
              spots: aiAccuracySpots,
              barWidth: 1.5,
              isStepLineChart: false,
              color: SupportBotColors.bluePrimary.shade400,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 3,
                    color: SupportBotColors.bluePrimary.shade400,
                    strokeWidth: 1,
                    strokeColor: Colors.transparent,
                  );
                },
              ),
            ),
            LineChartBarData(
              preventCurveOverShooting: true,
              isCurved: true,
              spots: validationPercentageSpots,
              barWidth: 1.5,
              isStepLineChart: false,
              color: SupportBotColors.bluePrimary.shade200,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 3,
                    color: SupportBotColors.bluePrimary.shade300,
                    strokeWidth: 1,
                    strokeColor: Colors.transparent,
                  );
                },
              ),
            ),
          ],
          minX: minX.toDouble(),
          maxX: maxX.toDouble(),
          minY: minY.toDouble(),
          maxY: maxY.toDouble(),
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBorder: BorderSide(
                width: 2,
                color: SupportBotColors.blueSecondary.shade200,
              ),
              getTooltipColor: (touchedSpot) =>
                  SupportBotColors.blueSecondary.shade200,
              tooltipRoundedRadius: 4,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((spot) {
                  String label = '';
                  String dateLabel = '';
                  Color tooltipColor = Colors.black;
                  int index = spot.x.toInt();

                  if (index >= 0 && index < dates.length) {
                    dateLabel = DateFormat('dd MMM yyyy')
                        .format(DateTime.parse(dates[index]));
                  }
                  if (spot.barIndex == 0) {
                    label =
                        'Date: $dateLabel,\nAI Accuracy: ${spot.y.toStringAsFixed(0)}%';
                    tooltipColor = SupportBotColors.bluePrimary.shade400;
                  } else if (spot.barIndex == 1) {
                    label = 'Validation: ${spot.y.toStringAsFixed(0)}%';
                    tooltipColor = SupportBotColors.bluePrimary.shade300;
                  }

                  return LineTooltipItem(
                    label,
                    SupportBotTextstyle.caption.copyWith(color: tooltipColor),
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

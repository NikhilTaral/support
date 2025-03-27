import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class AiAccuracyAndValidationTrendsLineGraph extends StatelessWidget {
  AiAccuracyAndValidationTrendsLineGraph(
      {super.key, required this.dashboardDataModel});

  final DashboardDataModel? dashboardDataModel;
  final List<dynamic>? apiResponseData = [];

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
    final aiAccuracyData = apiResponse.first['aiAccuracy'];
    final validationPercentageData = apiResponse.first['validationPercentage'];
    final dates = apiResponse.first['date'];

    List<FlSpot> aiAccuracySpots = [];
    List<FlSpot> validationPercentageSpots = [];

    for (int i = 0; i < aiAccuracyData.length; i++) {
      aiAccuracySpots.add(FlSpot(i.toDouble(), aiAccuracyData[i].toDouble()));
      validationPercentageSpots
          .add(FlSpot(i.toDouble(), validationPercentageData[i].toDouble()));
    }

    double minY = 0;
    double maxY = 100;
    double minX = 0;
    double maxX = aiAccuracySpots.length.toDouble();

    return SizedBox(
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
                interval: 20,
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
                  int index = value.toInt();
                  if (index >= 0 && index < dates.length) {
                    String formattedDate =
                        DateFormat('dd').format(DateTime.parse(dates[index]));
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        formattedDate,
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
              spots: aiAccuracySpots,
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
            LineChartBarData(
              spots: validationPercentageSpots,
              barWidth: 2,
              isStepLineChart: false,
              color: SupportBotColors.bluePrimary.shade200,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 5,
                    color: SupportBotColors.bluePrimary.shade300,
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
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBorder: BorderSide(
                  width: 2, color: SupportBotColors.blueSecondary.shade200),
              getTooltipColor: (touchedSpot) =>
                  SupportBotColors.blueSecondary.shade200,
              tooltipRoundedRadius: 8,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((spot) {
                  String label = '';
                  Color tooltipColor = Colors.black;

                  if (spot.barIndex == 0) {
                    label = 'AI Accuracy: ${spot.y.toStringAsFixed(0)}%';
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

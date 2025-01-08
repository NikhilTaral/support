import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';

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
    if (apiResponse == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("FL Line Chart Example")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final counts = apiResponse['counts'] as Map<String, dynamic>? ?? {};
    if (counts.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("FL Line Chart Example")),
        body: const Center(child: Text("No data available")),
      );
    }

    int size = dashboardDataModel
            ?.getValidationByCountAttributeModel?.data?.counts?.length ??
        0;
    int length = size;
    List<FlSpot> spots = [];
    double index = 1;
    counts.forEach((key, value) {
      spots.add(FlSpot(index, value.toDouble()));
      index++;
    });

    double maxY = spots.isNotEmpty
        ? spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 10
        : 10;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: (length + 1) * 50,
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(
              show: false,
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
                  interval: 2,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
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
                    if (value.toInt() < length) {
                      int index = value.toInt();
                      if (index < counts.length) {
                        String title = counts.keys.elementAt(index);
                        String data = title.split('@')[0];
                        String name = data.replaceAll('.', ' \n');
                        return Container(
                          padding: const EdgeInsets.only(
                            left: 100.0,
                          ),
                          child: Text(
                            name,
                            style: const TextStyle(fontSize: 8),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
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
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
                left: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
                right: BorderSide(
                  color: Colors.transparent,
                  width: 0,
                ),
                top: BorderSide(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                spots: spots,
                barWidth: 2,
                color: SupportBotColors.blueSecondary.shade400,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 5,
                      color: SupportBotColors.bluePrimary.shade400,
                      strokeWidth: 2,
                      strokeColor: Colors.transparent,
                    );
                  },
                ),
              ),
            ],
            minX: 0,
            maxX: length.toDouble(),
            minY: 0,
            maxY: maxY,
          ),
        ),
      ),
    );
  }
}

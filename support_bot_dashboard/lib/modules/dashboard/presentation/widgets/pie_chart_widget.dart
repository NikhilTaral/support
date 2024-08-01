import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_chart_attribute_model.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class PieChartWidget extends StatefulWidget {
  final DashboardChartAttributeModel? data;
  const PieChartWidget({super.key, this.data});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState(data: data);
}

class _PieChartWidgetState extends State<PieChartWidget> {
  final DashboardChartAttributeModel? data;
  int? touchedIndex;

  _PieChartWidgetState({required this.data});

  @override
  Widget build(BuildContext context) {
    List<Color> blueShades = [
      const Color.fromARGB(255, 153, 172, 187),
      const Color.fromARGB(255, 61, 121, 170),
      const Color.fromARGB(255, 28, 88, 136),
      const Color.fromARGB(255, 17, 58, 98),
    ];
    double radius = UIHelpers.screenWidth(context) * 0.08;

    final chartData = [
      ChartData(label: 'Genuine Query', value: data?.genuineQuery),
      ChartData(label: 'No Action Required', value: data?.noActionRequired),
      ChartData(label: 'Spam/Marketing', value: data?.spamMarketing),
      ChartData(label: 'Acknowledgement Required', value: data?.acknowledgement)
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25, left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UIHelpers.verticalSpaceRegular,
            const Text(
              'Ticket Classification',
              style: SupportBotTextstyle.pierchartHeading,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Divider(color: SupportBotColors.blueSecondary.shade200),
            ),
            SizedBox(
              height: UIHelpers.screenHeight(context) * 0.5,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  centerSpaceRadius: 1,
                  sectionsSpace: 1,
                  sections: List.generate(
                    chartData.length,
                    (index) {
                      final isTouched = index == touchedIndex;
                      final double fontSize = isTouched ? 16 : 16;
                      return PieChartSectionData(
                        value: chartData[index].value?.toDouble() ?? 0,
                        title: isTouched
                            ? '${chartData[index].label}: ${chartData[index].value}'
                            : null,
                        color: blueShades[index % blueShades.length],
                        radius: radius,
                        titleStyle:
                            SupportBotTextstyle.pierchartNormal.copyWith(
                          fontSize: fontSize,
                        ),
                        showTitle: true,
                      );
                    },
                  ),
                ),
              ),
            ),
            UIHelpers.horizontalSpaceSmallRegular,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                chartData.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: UIHelpers.screenWidth(context) * 0.01,
                        height: UIHelpers.screenHeight(context) * 0.02,
                        color: blueShades[index % blueShades.length],
                      ),
                      UIHelpers.horizontalSpaceTiny,
                      Text(
                        chartData[index].label ?? '',
                        style: SupportBotTextstyle.pierchartLabel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

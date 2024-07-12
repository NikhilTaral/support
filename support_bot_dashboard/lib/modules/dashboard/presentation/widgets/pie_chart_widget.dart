
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_chart_attribute_model.dart';
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
      const Color.fromARGB(255, 28, 88, 136),
      const Color.fromARGB(255, 17, 58, 98),
    ];
    double radius = UIHelpers.screenWidth(context) / 10;

    final chartData = [
      ChartData(label: 'Genuine Query', value: data?.genuineQuery),
      ChartData(label: 'No Action Required', value: data?.noActionRequired),
      ChartData(label: 'Spam/Marketing', value: data?.spamMarketing),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 70),
          child: Text(
            'Ticket Classification',
            style: SupportBotTextstyle.pierchartHeading,
          ),
        ),
        SizedBox(
          height: UIHelpers.screenHeight(context) / 1.8,





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
                    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              centerSpaceRadius: 1,
              sectionsSpace: 1,
              sections: List.generate(
                chartData.length,
                (index) {
                  final isTouched = index == touchedIndex;
                  final double fontSize = isTouched ? 16 : 11;
                  return PieChartSectionData(
                    value: chartData[index].value?.toDouble() ?? 0,
                    title: '${chartData[index].label}\n${chartData[index].value}',
                    color: blueShades[index % blueShades.length],
                    radius: radius,
                    titleStyle: SupportBotTextstyle.pierchartNormal.copyWith(
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
                    width: UIHelpers.screenWidth(context) / 76,
                    height: UIHelpers.screenHeight(context) / 45,
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
    );
  }
}

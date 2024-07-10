import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_chart_attribute_model.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';
 
class PieChartWidget extends StatelessWidget {
  final DashboardChartAttributeModel? data;

  const PieChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<Color> blueShades = [
      const Color.fromARGB(255, 153, 172, 187),
      const Color.fromARGB(255, 28, 88, 136),
      const Color.fromARGB(255, 17, 58, 98),
    ];
    double radius = UIHelpers.screenWidth(context) / 12;

    final chartData = [
      ChartData(label: 'Genuine Query', value: data?.genuineQuery),
      ChartData(label: 'No Action Required', value: data?.noActionRequired),
      ChartData(label: 'Spam/Marketing', value: data?.spamMarketing),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 35),
          child: Text(
            'Pie Chart Title',
            style: SupportBotTextstyle.pierchartHeading,
          ),
        ),
        SizedBox(
          height: UIHelpers.screenHeight(context) / 2,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 0,
              sectionsSpace: 1,
              sections: List.generate(
                chartData.length,
                (index) => PieChartSectionData(
                  value: chartData[index].value?.toDouble() ?? 0,
                  title: chartData[index].label ?? '',
                  color: blueShades[index % blueShades.length],
                  radius: radius,
                  titleStyle: SupportBotTextstyle.pierchartNormal,
                  showTitle: true,
                ),
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

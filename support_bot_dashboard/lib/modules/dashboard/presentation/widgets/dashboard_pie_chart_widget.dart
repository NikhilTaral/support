import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
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
      ChartData(label: S.of(context).genuineQuery, value: data?.genuineQuery),
      ChartData(
          label: S.of(context).noActionRequired, value: data?.noActionRequired),
      ChartData(label: S.of(context).spam, value: data?.spamMarketing),
      ChartData(
          label: S.of(context).acknowledgementRequired,
          value: data?.acknowledgement)
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 25, left: 15, right: 15),
      child: Container(
        padding: const EdgeInsets.all(8),
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
            Text(
              S.of(context).ticketClassification,
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
                      final double fontSize = isTouched ? 12 : 14;
                      return PieChartSectionData(
                        value: chartData[index].value?.toDouble() ?? 0,
                        title: isTouched
                            ? '${chartData[index].label}\n${chartData[index].value}'
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
                  child: _piechartDetails(
                    color: blueShades[index % blueShades.length],
                    label: chartData[index].label ?? '',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _piechartDetails({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: UIHelpers.screenWidth(context) * 0.01,
          height: UIHelpers.screenHeight(context) * 0.02,
          color: color,
        ),
        UIHelpers.horizontalSpaceTiny,
        Expanded(
          child: Text(
            label,
            style: SupportBotTextstyle.pierchartLabel,
          ),
        ),
      ],
    );
  }
}

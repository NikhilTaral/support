import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_chart_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_chart_attribute_model.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class PieChartWidget extends StatefulWidget {
  final Object? data;
  final bool isAIQuery;

  const PieChartWidget({super.key, this.data, this.isAIQuery = false});

  @override
  State<PieChartWidget> createState() => PieChartWidgetState(data: data);
}

class PieChartWidgetState extends State<PieChartWidget> {
  final Object? data;
  int? touchedIndex;

  PieChartWidgetState({required this.data});

  @override
  Widget build(BuildContext context) {
    List<Color> blueShades = [
      const Color.fromARGB(255, 153, 172, 187),
      const Color.fromARGB(255, 61, 121, 170),
      const Color.fromARGB(255, 28, 88, 136),
      const Color.fromARGB(255, 17, 58, 98),
    ];
    double radius = UIHelpers.screenWidth(context) * 0.08;

    List<ChartData> chartData;

    if (widget.isAIQuery && data is DashboardAiQueryChartAttributeModel) {
      final aiData = data as DashboardAiQueryChartAttributeModel;
      chartData = [
        ChartData(
            label: 'AI Query Answer',
            value: aiData.aiQueryAnswer),
        ChartData(
            label: 'AI Query Not Answer',
            value: aiData.aiQueryNotAnswer),
      ];
    } else if (data is DashboardChartAttributeModel) {
      final dashboardData = data as DashboardChartAttributeModel;
      chartData = [
        ChartData(
            label: S.of(context).genuineQuery,
            value: dashboardData.genuineQuery),
        ChartData(
            label: S.of(context).noActionRequired,
            value: dashboardData.noActionRequired),
        ChartData(label: S.of(context).spam, value: dashboardData.spamMarketing),
        ChartData(
            label: S.of(context).acknowledgementRequired,
            value: dashboardData.acknowledgement)
      ];
    } else {
      chartData = [];
    }

    final nonZeroChartData = chartData
        .where((data) => data.value != null && data.value! > 0)
        .toList();

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
      child: Container(
        height: UIHelpers.screenHeight(context) * 0.77,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UIHelpers.verticalSpaceRegular,
              Text(
                widget.isAIQuery
                  ? S.of(context).aiQueryAnswer
                  : S.of(context).ticketClassification,
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
                                  .touchedSection?.touchedSectionIndex ??
                              0;
                        });
                      },
                    ),
                    centerSpaceRadius: 1,
                    sectionsSpace: 1,
                    sections: List.generate(
                      nonZeroChartData.length,
                      (index) {
                        final isTouched = index == touchedIndex;
                        final double fontSize = isTouched ? 12 : 14;
                        return PieChartSectionData(
                          value: nonZeroChartData[index].value?.toDouble() ?? 0.0,
                          title: isTouched
                              ? '${nonZeroChartData[index].label}\n${nonZeroChartData[index].value}'
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
                  nonZeroChartData.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: _piechartDetails(
                      color: blueShades[index % blueShades.length],
                      label: nonZeroChartData[index].label ?? '',
                    ),
                  ),
                ),
              ),
            ],
          ),
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
        Flexible(
          child: Text(
            label,
            style: SupportBotTextstyle.pierchartLabel,
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}


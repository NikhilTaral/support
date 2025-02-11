import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/pipeline_tile_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_tile_bloc/pipeline_tile_bloc.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class DashboardPipelineChart extends StatelessWidget {
  const DashboardPipelineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PipelineTileBloc, PipelineTileState>(
      builder: (context, state) {
        if (state is PipelineTileSuccessState) {
          final data = state.pipelineTileAttributeModel?.data?.items;

          return Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Pipeline",
                      style: SupportBotTextstyle.normal.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: SupportBotColors.black,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<PipelineTileBloc>()
                            .add(TogglePipelineChartVisibilityEvent());
                      },
                      child: Icon(
                        state.isChartVisible
                            ? SupportBotIcons.eye
                            : SupportBotIcons.visibilityOff,
                        color: SupportBotColors.bluePrimary.shade400,
                      ),
                    ),
                    UIHelpers.horizontalSpaceMedium,
                  ],
                ),
                UIHelpers.verticalSpaceRegular,
                if (state.isChartVisible)
                  Expanded(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 25.0),
                              child: SizedBox(
                                width: (data?.length ?? 0) * 250,
                                height: (data?.length ?? 0) * 30,
                                child: CustomPipelineChart(
                                  pipleineData: data,
                                ),
                              ),
                            ),
                          ),
                        ),
                        UIHelpers.verticalSpaceRegular,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: SupportBotColors.bluePrimary.shade400,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            UIHelpers.horizontalSpaceSmall,
                            Text("Validated Tickets",
                                style: SupportBotTextstyle.normal.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                )),
                            UIHelpers.horizontalSpaceMedium,
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: SupportBotColors.bluePrimary.shade200,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            UIHelpers.horizontalSpaceSmall,
                            Text("Total Tickets",
                                style: SupportBotTextstyle.normal.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

class CustomPipelineChart extends StatelessWidget {
  final List<AttributeItem>? pipleineData;

  CustomPipelineChart({
    Key? key,
    required this.pipleineData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxTotalTickets = pipleineData
            ?.map((e) => e.totalTickets ?? 0)
            .fold(0, (prev, next) => prev > next ? prev : next) ??
        0;
    final int numberOfDivisions = maxTotalTickets > 500 ? 15 : 5;
    final intervalValue = (maxTotalTickets / numberOfDivisions).ceilToDouble();

    return RotatedBox(
      quarterTurns: 1,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: pipleineData!
              .map((e) => e.totalTickets)
              .toList()
              .reduce((curr, next) => (curr ?? 0) > next! ? curr : next)
              ?.toDouble(),
          minY: 0,
          barGroups: List.generate(pipleineData?.length ?? 0, (index) {
            final item = pipleineData?[index];
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: item?.totalTickets?.toDouble() ?? 0,
                  color: SupportBotColors.bluePrimary.shade200,
                  width: 20,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  rodStackItems: [
                    BarChartRodStackItem(
                      0,
                      item?.validatedTickets?.toDouble() ?? 0,
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
                reservedSize: 200,
                interval: 1,
                getTitlesWidget: (double value, TitleMeta meta) {
                  int index = value.toInt();
                  if (index > 0 && index < (pipleineData?.length ?? 0)) {
                    return RotatedBox(
                      quarterTurns: -1,
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          pipleineData?[index].pipelineName ?? '',
                          style: SupportBotTextstyle.normal.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
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
                interval: intervalValue,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 100,
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
              direction: TooltipDirection.bottom,
              rotateAngle: 270,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  'Validated: ${pipleineData?[groupIndex].validatedTickets?.toInt()} / Total: ${pipleineData?[groupIndex].totalTickets?.toInt()}',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ticket_classification_pi_chart.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class TicketClassificationWidget extends StatelessWidget {
  const TicketClassificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: SupportBotColors.blueSecondary.shade100,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ticket Classification",
              style: SupportBotTextstyle.normal.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: SupportBotColors.black),
            ),
            UIHelpers.verticalSpaceRegular,
            BlocBuilder<TicketClassificationBloc, TicketClassificationState>(
              builder: (context, state) {
                if (state is TicketClassificationSucssesState) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 240,
                        width: 240,
                        child: state.dashboardDataModel != null
                            ? FlCircularChart(
                                dashboardDataModel: state.dashboardDataModel!)
                            : const SizedBox.shrink(),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          spacing: 10,
                          children: [
                            _buildClassificationRow(
                              context,
                              color: SupportBotColors.bluePrimary.shade400,
                              title: "Genuine Query",
                              percentage:
                                  "${state.dashboardDataModel?.pieChartData?.data?.percentages?.genuineQuery}%",
                            ),
                            _buildClassificationRow(
                              context,
                              color: const Color(0xFF8099C7),
                              title: "No Action Required",
                              percentage:
                                  "${state.dashboardDataModel?.pieChartData?.data?.percentages?.noActionRequired}%",
                            ),
                            _buildClassificationRow(
                              context,
                              color: const Color(0xFFB6C5DF),
                              title: "Spam/Marketing",
                              percentage:
                                  "${state.dashboardDataModel?.pieChartData?.data?.percentages?.spamMarketing}%",
                            ),
                            _buildClassificationRow(
                              context,
                              color: const Color(0xFFDBE2EF),
                              title: "Acknowledgement Required",
                              percentage:
                                  "${state.dashboardDataModel?.pieChartData?.data?.percentages?.acknowledgementRequired}%",
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state is TicketClassificationLoadingState) {
                  return const LoadingWidget(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      width: double.infinity,
                      height: 280);
                } else if (state is TicketClassificationFailureState) {
                  return FailureWidget(
                    onTap: () {
                      BlocProvider.of<TicketClassificationBloc>(context)
                          .add(TickiteClassificationEvent());
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ));
  }

  Widget _buildClassificationRow(
    BuildContext context, {
    required Color color,
    required String title,
    required String percentage,
  }) {
    return Container(
      padding: const EdgeInsets.all(6),
      constraints: const BoxConstraints(maxWidth: 330),
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: SupportBotColors.blueSecondary.shade100,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  height: 24,
                  width: 24,
                ),
                UIHelpers.horizontalSpaceSmall,
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: SupportBotTextstyle.normal.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: SupportBotColors.black),
                  ),
                ),
              ],
            ),
          ),
          Text(
            percentage,
            style: SupportBotTextstyle.small.copyWith(
                fontWeight: FontWeight.w400,
                color: SupportBotColors.blueSecondary),
          ),
        ],
      ),
    );
  }
}

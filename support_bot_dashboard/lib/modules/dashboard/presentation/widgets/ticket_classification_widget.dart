import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ticket_classification_pi_chart.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class TicketClassificationWidget extends StatelessWidget {
  const TicketClassificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: SupportBotColors.blueSecondary.shade100,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: BlocProvider(
        create: (context) =>
            TicketClassificationBloc()..add(TickiteClassificationEvent()),
        child: BlocBuilder<TicketClassificationBloc, TicketClassificationState>(
            builder: (context, state) {
          if (state is TicketClassificationSucssesState) {
            return Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ticket Classification",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  UIHelpers.verticalSpaceRegular,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 250,
                        width: 255,
                        child: state.dashboardDataModel != null
                            ? FlCircularChart(
                                dashboardDataModel: state.dashboardDataModel!)
                            : const SizedBox.shrink(),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            width: UIHelpers.screenWidth(context) * 0.2,
                            height: 46,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: SupportBotColors.blueSecondary.shade100,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        SupportBotColors.bluePrimary.shade400,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  height: 24,
                                  width: 24,
                                ),
                                const Spacer(),
                                const Expanded(
                                  flex: 3,
                                  child: Text("genuine Query"),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                      " ${state.dashboardDataModel?.pieChartData?.data?.percentages?.genuineQuery}%"),
                                ),
                              ],
                            ),
                          ),

                          // Second container for the second set of data
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            width: UIHelpers.screenWidth(context) * 0.2,
                            height: 46,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: SupportBotColors.blueSecondary.shade100,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF8099C7),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  height: 24,
                                  width: 24,
                                ),
                                const Spacer(),
                                const Expanded(
                                  flex: 3,
                                  child: Text("No Action Required"),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                      " ${state.dashboardDataModel?.pieChartData?.data?.percentages?.noActionRequired}%"),
                                ),
                              ],
                            ),
                          ),

                          // Third container for the third set of data
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            width: UIHelpers.screenWidth(context) * 0.2,
                            height: 46,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: SupportBotColors.blueSecondary.shade100,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFB6C5DF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  height: 24,
                                  width: 24,
                                ),
                                const Spacer(),
                                const Expanded(
                                  flex: 3,
                                  child: Text("Spam/Marketing"),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                      " ${state.dashboardDataModel?.pieChartData?.data?.percentages?.spamMarketing}%"),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            width: UIHelpers.screenWidth(context) * 0.2,
                            height: 46,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: SupportBotColors.blueSecondary.shade100,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDBE2EF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  height: 24,
                                  width: 24,
                                ),
                                const Spacer(),
                                const Expanded(
                                  flex: 3,
                                  child: Text("No Action Required"),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                      " ${state.dashboardDataModel?.pieChartData?.data?.percentages?.acknowledgementRequired}%"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          } else if (state is TicketClassificationLoadingState) {
            return Container(
                child: LoadingWidget(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    width: double.infinity,
                    height: UIHelpers.screenHeight(context)));
          } else if (state is TicketClassificationFailureState) {
            return Container(
                alignment: Alignment.center,
                child: Text("Oops! Something went wrong. . . . "));
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}

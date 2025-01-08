import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_Edited_answer_bolc/ai_query_Edited_answer_bloc.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class AiQueryEditedAnswerWidget extends StatelessWidget {
  const AiQueryEditedAnswerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            AiQueryEditedAnswerBloc()..add(AIQueryEditedAnswerCallEvent()),
        child: BlocBuilder<AiQueryEditedAnswerBloc, AiQueryEditedAnswerState>(
            builder: (context, state) {
          if (state is AIQueryEditedAnswerSucssesState) {
            return _content(state);
          } else if (state is AIQueryEditedAnswerLoadingState) {
            return _loadingView(context);
          } else if (state is AIQueryEditedAnswerFailureState) {
            return const Text('Failed to load user validation data');
          } else {
            return const SizedBox.shrink();
          }
        }));
  }

  Widget _content(AIQueryEditedAnswerSucssesState state) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
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
                  const Text(
                    "AI Query Edited",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: SupportBotColors.blueSecondary.shade100,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: SupportBotColors.bluePrimary,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Transform.rotate(
                                    angle: 45 * math.pi / 180,
                                    child: const Icon(
                                      Icons.add,
                                      color: SupportBotColors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                Text(
                                    "Query Edited:  ${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.answered}%"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      UIHelpers.horizontalSpaceRegular,
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: SupportBotColors.blueSecondary.shade100,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: SupportBotColors.bluePrimary,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: SupportBotColors.white,
                                    size: 18,
                                  ),
                                ),
                                Text(
                                    "Query Non Edited: ${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.notAnswered}%"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            UIHelpers.verticalSpaceMedium,
            Container(
              padding: const EdgeInsets.all(20),
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
                  const Text(
                    "AI Query Answer",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: SupportBotColors.blueSecondary.shade100,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: SupportBotColors.bluePrimary,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Transform.rotate(
                                    angle: 45 * math.pi / 180,
                                    child: const Icon(
                                      Icons.add,
                                      color: SupportBotColors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                Text(
                                    "AI Query Not Answer: ${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.notAnswered}"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      UIHelpers.horizontalSpaceRegular,
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: SupportBotColors.blueSecondary.shade100,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: SupportBotColors.bluePrimary,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: SupportBotColors.white,
                                    size: 18,
                                  ),
                                ),
                                Text(
                                    "AI Query Answer:  ${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.answered}"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelpers.verticalSpaceMedium,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingView(BuildContext context) {
    return LoadingWidget(
        borderRadius: const BorderRadius.all(const Radius.circular(8)),
        width: double.infinity,
        height: UIHelpers.screenHeight(context));
  }
}

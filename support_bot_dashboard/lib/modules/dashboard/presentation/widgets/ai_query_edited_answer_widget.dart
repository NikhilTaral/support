import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_Edited_answer_bolc/ai_query_Edited_answer_bloc.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
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
    return Padding(
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
                Text(
                  "AI Query Edited",
                  style: SupportBotTextstyle.normal.copyWith(
                      fontWeight: FontWeight.w600,
                      color: SupportBotColors.black),
                ),
                UIHelpers.verticalSpaceSmall,
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
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: SupportBotColors.bluePrimary.shade400,
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
                              UIHelpers.verticalSpaceSmall,
                              Text(
                                "Query Edited:  ${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.answered}%",
                                style: SupportBotTextstyle.small.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: SupportBotColors.black),
                              ),
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
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: SupportBotColors.bluePrimary.shade400,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: SupportBotColors.white,
                                  size: 18,
                                ),
                              ),
                              UIHelpers.verticalSpaceSmall,
                              Text(
                                "Query Non Edited: ${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.notAnswered}%",
                                style: SupportBotTextstyle.small.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: SupportBotColors.black),
                              ),
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
                Text(
                  "AI Query Answer",
                  style: SupportBotTextstyle.normal.copyWith(
                      fontWeight: FontWeight.w600,
                      color: SupportBotColors.black),
                ),
                UIHelpers.verticalSpaceSmall,
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
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: SupportBotColors.bluePrimary.shade400,
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
                              UIHelpers.verticalSpaceSmall,
                              Text(
                                "AI Query Not Answer: ${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.notAnswered}",
                                style: SupportBotTextstyle.small.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: SupportBotColors.black),
                              ),
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
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: SupportBotColors.bluePrimary.shade400,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: SupportBotColors.white,
                                  size: 18,
                                ),
                              ),
                              UIHelpers.verticalSpaceSmall,
                              Text(
                                "AI Query Answer:  ${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.answered}",
                                style: SupportBotTextstyle.small.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: SupportBotColors.black),
                              ),
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
    );
  }

  Widget _loadingView(BuildContext context) {
    return LoadingWidget(
        borderRadius: const BorderRadius.all(const Radius.circular(8)),
        width: double.infinity,
        height: UIHelpers.screenHeight(context));
  }
}

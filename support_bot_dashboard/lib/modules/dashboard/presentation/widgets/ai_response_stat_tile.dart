import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/evaluation_bar_chart.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/get_ai_reponse_stat_bloc/get_ai_response_stat_bloc.dart';

class AiResponseStatTile extends StatelessWidget {
   AiResponseStatTile({super.key});
final s=serviceLocator<S>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: SupportBotColors.blueSecondary.shade100, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.aiResponseStatText,
            style: SupportBotTextstyle.normal.copyWith(fontWeight: FontWeight.w600, fontSize: 18, color: SupportBotColors.black),
          ),
          UIHelpers.verticalSpaceRegular,
          BlocBuilder<GetAiResponseStatBloc, GetAiResponseStatState>(builder: (context, state) {
            if (state is GetAiResponseStatSuccessState) {
              return SizedBox(
                  height: 200,
                  child: EvaluationBarChart(
                    evaluationData: [
                      EvaluationData(
                        timeLabel: s.correctText,
                        percentage: state.getAiResponseStatAttributeModel?.percentages?.correctResponses ?? 0,
                        totalResponses: state.getAiResponseStatAttributeModel?.counts?.validatedResponses ?? 0,
                        totalCorrectOrIncorrect: state.getAiResponseStatAttributeModel?.counts?.correctResponses??0
                      ),
                      EvaluationData(
                        timeLabel: s.incorrectText,
                        percentage: state.getAiResponseStatAttributeModel?.percentages?.incorrectResponses ?? 0,
                        totalResponses: state.getAiResponseStatAttributeModel?.counts?.validatedResponses ?? 0,
                        totalCorrectOrIncorrect: state.getAiResponseStatAttributeModel?.counts?.incorrectResponses??0
                      ),
                    ],
                  ));
            } else if (state is GetAiResponseStatLoadingState) {
              return const LoadingWidget(width: double.infinity, height: 200);
            } else if (state is GetAiResponseStatEmptyState) {
              return const EmptyWidget();
            } else if (state is GetAiResponseStatFailureState) {
              return FailureWidget(
                onTap: () {
                  BlocProvider.of<GetAiResponseStatBloc>(context).add(GetAiResponseStatInitialEvent());
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}

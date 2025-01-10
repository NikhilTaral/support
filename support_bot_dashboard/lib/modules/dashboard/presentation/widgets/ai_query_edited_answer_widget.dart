import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_edited_answer_bloc/ai_query_Edited_answer_bloc.dart';
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
        },
      ),
    );
  }

  Widget _content(AIQueryEditedAnswerSucssesState state) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard(
            title: 'AI Query Edited',
            editedText:
                'Query Edited: ${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.answered}%',
            nonEditedText:
                'Query Non Edited: ${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.notAnswered}%',
          ),
          UIHelpers.verticalSpaceMedium,
          _buildInfoCard(
            title: 'AI Query Answer',
            editedText:
                'AI Query Answer: ${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.answered}',
            nonEditedText:
                'AI Query Not Answer: ${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.notAnswered}',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String editedText,
    required String nonEditedText,
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        border: Border.all(
            color: SupportBotColors.blueSecondary.shade100, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: SupportBotTextstyle.normal.copyWith(
              fontWeight: FontWeight.w600,
              color: SupportBotColors.black,
            ),
          ),
          UIHelpers.verticalSpaceSmall,
          Row(
            children: [
              _buildStatisticCard(icon: Icons.add, text: editedText),
              UIHelpers.horizontalSpaceRegular,
              _buildStatisticCard(icon: Icons.check, text: nonEditedText),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticCard({
    required IconData icon,
    required String text,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: SupportBotColors.blueSecondary.shade100, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(icon),
              UIHelpers.verticalSpaceSmall,
              Text(
                text,
                style: SupportBotTextstyle.small.copyWith(
                  fontWeight: FontWeight.w400,
                  color: SupportBotColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: SupportBotColors.bluePrimary.shade400,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Transform.rotate(
        angle: 45 * math.pi / 180,
        child: Icon(
          icon,
          color: SupportBotColors.white,
          size: 18,
        ),
      ),
    );
  }

  Widget _loadingView(BuildContext context) {
    return LoadingWidget(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      width: double.infinity,
      height: UIHelpers.screenHeight(context),
    );
  }
}

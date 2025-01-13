import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_edited_bloc/ai_query_edited_bloc.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class AiQueryEditedTile extends StatelessWidget {
  const AiQueryEditedTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
            color: SupportBotColors.blueSecondary.shade100, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Query Edited',
            style: SupportBotTextstyle.normal.copyWith(
              fontWeight: FontWeight.w600,
              color: SupportBotColors.black,
            ),
          ),
          UIHelpers.verticalSpaceSmall,
          BlocBuilder<AiQueryEditedBloc, AiQueryEditedState>(
            builder: (context, state) {
              if (state is AIQueryEditedSucssesState) {
                return _content(state);
              } else if (state is AIQueryEditedLoadingState) {
                return _loadingView(context);
              } else if (state is AIQueryEditedFailureState) {
                return FailureWidget(
                  onTap: () {
                    BlocProvider.of<AiQueryEditedBloc>(context)
                        .add(AIQueryEditedInitialEvent());
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _content(AIQueryEditedSucssesState state) {
    return _buildInfoCard(
      editedText:
          'Query Edited: ${state.dashboardAiQueryEditedAttributeModel?.data?.percentages?.editedCount}%',
      nonEditedText:
          'Query Non Edited: ${state.dashboardAiQueryEditedAttributeModel?.data?.percentages?.unEditedCount}%',
    );
  }

  Widget _buildInfoCard({
    required String editedText,
    required String nonEditedText,
  }) {
    return Row(
      children: [
        _buildStatisticCard(icon: Icons.add, text: editedText),
        UIHelpers.horizontalSpaceRegular,
        _buildStatisticCard(icon: Icons.check, text: nonEditedText),
      ],
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
        angle: 0,
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

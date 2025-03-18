import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_answer_bloc/ai_query_answer_bloc.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class AiQueryAnswerTile extends StatelessWidget {
  AiQueryAnswerTile({super.key});
  final s = serviceLocator<S>();
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
            s.aiTicketsAnswerText,
            style: SupportBotTextstyle.normal.copyWith(
              fontWeight: FontWeight.w600,
              color: SupportBotColors.black,
            ),
          ),
          UIHelpers.verticalSpaceSmall,
          BlocBuilder<AiQueryAnswerBloc, AiQueryAnswerState>(
            builder: (context, state) {
              if (state is AIQueryAnswerSucssesState) {
                return _content(state);
              } else if (state is AIQueryAnswerLoadingState) {
                return _loadingView(context);
              } else if (state is AIQueryAnswerFailureState) {
                return FailureWidget(
                  onTap: () {
                    BlocProvider.of<AiQueryAnswerBloc>(context)
                        .add(AIQueryAnswerInitialEvent());
                  },
                );
              } else if (state is AIQueryAnswerEmptyState) {
                return const EmptyWidget();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _content(AIQueryAnswerSucssesState state) {
    return _buildInfoCard(
      editedText:
          '${s.ticketsAnswerText}${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.answered} (${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.percentages?.answered}%)',
      nonEditedText:
          '${s.ticketsNotAnswerText} ${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.counts?.notAnswered} (${state.dashboardDataModel?.dashboardAiQueryChartAttributeModel?.data?.percentages?.notAnswered}%)',
    );
  }

  Widget _buildInfoCard({
    required String editedText,
    required String nonEditedText,
  }) {
    return Row(
      children: [
        _buildStatisticCard(
            icon: Icons.check, text: editedText, isRotated: false),
        UIHelpers.horizontalSpaceRegular,
        _buildStatisticCard(
            icon: Icons.add, text: nonEditedText, isRotated: true),
      ],
    );
  }

  Widget _buildStatisticCard({
    required IconData icon,
    required String text,
    required bool isRotated,
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
              _buildIcon(icon, isRotated),
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

  Widget _buildIcon(IconData icon, bool isRotated) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: SupportBotColors.bluePrimary.shade400,
        borderRadius: BorderRadius.circular(6),
      ),
      child: isRotated
          ? Transform.rotate(
              angle: 45 * math.pi / 180,
              child: Icon(
                icon,
                color: SupportBotColors.white,
                size: 18,
              ),
            )
          : Icon(
              icon,
              color: SupportBotColors.white,
              size: 18,
            ),
    );
  }

  Widget _loadingView(BuildContext context) {
    return const LoadingWidget(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      width: double.infinity,
      height: 120,
    );
  }
}

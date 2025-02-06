import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_edited_bloc/ai_query_edited_bloc.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class AiQueryEditedTile extends StatelessWidget {
   AiQueryEditedTile({super.key});
final s = serviceLocator<S>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
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
            s.aiTicketsEditedText,
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
              } else if (state is AIQueryEditedEmptyState) {
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

  Widget _content(AIQueryEditedSucssesState state) {
    return _buildInfoCard(
      editedText:
         ' ${s.ticketEditedText} ${state.dashboardAiQueryEditedAttributeModel?.data?.counts?.editedCount} (${state.dashboardAiQueryEditedAttributeModel?.data?.percentages?.editedCount}%)',
      nonEditedText:
          '${s.ticketNotEditedText} ${state.dashboardAiQueryEditedAttributeModel?.data?.counts?.unEditedCount} (${state.dashboardAiQueryEditedAttributeModel?.data?.percentages?.unEditedCount}%)',
    );
  }

  Widget _buildInfoCard({
    required String editedText,
    required String nonEditedText,
  }) {
    return Row(
      children: [
        _buildStatisticCard(icon: Icons.add, text: editedText, useSvg: false),
        UIHelpers.horizontalSpaceRegular,
        _buildStatisticCard(text: nonEditedText, useSvg: true),
      ],
    );
  }

  Widget _buildStatisticCard({
    IconData? icon,
    required String text,
    required bool useSvg,
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
              useSvg
                  ? Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: SupportBotColors.bluePrimary.shade400,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/WarningCircle.svg",
                      ),
                    )
                  : _buildIcon(icon!),
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
    return const LoadingWidget(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      width: double.infinity,
      height: 120,
    );
  }
}

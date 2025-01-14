import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ai_query_answer_tile.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ai_query_edited_tile.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/validation_status_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ticket_classification_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/user_validation_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class Charts extends StatelessWidget {
  const Charts({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = UIHelpers.screenHeight(context);
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const TicketClassificationWidget(),
                UIHelpers.verticalSpace(16),
                _buildValidationStatusCard(screenHeight, context),
              ],
            ),
          ),
          UIHelpers.horizontalSpaceSmall,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserValidationCard(),
                UIHelpers.verticalSpaceRegular,
                _buildAiQueryEditedAnswerCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationStatusCard(double screenHeight, BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.47,
      child: ValidationStatusWidget(),
    );
  }

  Widget _buildUserValidationCard() {
    return Container(
      width: 800,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
            color: SupportBotColors.blueSecondary.shade100, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            "User Validation",
            style: SupportBotTextstyle.normal.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: SupportBotColors.black),
          ),
          const UserValidationWidget(),
        ],
      ),
    );
  }

  Widget _buildAiQueryEditedAnswerCard() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [AiQueryAnswerTile(), AiQueryEditedTile()],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ai_query_edited_answer_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/validation_status_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ticket_classification_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/user_validation_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class Charts extends StatelessWidget {
  const Charts({super.key, this.dashboardDataModel});
  final DashboardDataModel? dashboardDataModel;

  @override
  Widget build(BuildContext context) {
    final screenHeight = UIHelpers.screenHeight(context);
    final screenWidth = UIHelpers.screenWidth(context);

    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: SupportBotColors.blueSecondary.shade100, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 1, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelpers.verticalSpaceSmall,
            Text(
              "Validation Status",
              style: SupportBotTextstyle.normal.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: SupportBotColors.black),
            ),
            SizedBox(
              height: screenHeight * 0.4,
              child: ValidationStatusWidget(list: dashboardDataModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserValidationCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: SupportBotColors.blueSecondary.shade100, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const UserValidationWidget(),
    );
  }

  Widget _buildAiQueryEditedAnswerCard() {
    return const AiQueryEditedAnswerWidget();
  }
}

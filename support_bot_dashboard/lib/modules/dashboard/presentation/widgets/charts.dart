import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ai_query_edited_answer_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/validation_status_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ticket_classification_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/user_validation_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class Charts extends StatelessWidget {
  Charts({super.key, this.dashboardDataModel});
  final DashboardDataModel? dashboardDataModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: UIHelpers.screenHeight(context),
      width: UIHelpers.screenWidth(context),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                const Expanded(flex: 5, child: TicketClassificationWidget()),
                UIHelpers.verticalSpace(16),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: SupportBotColors.blueSecondary.shade100,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1, left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Validation Status",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Container(
                              height: UIHelpers.screenHeight(context) * 0.4,
                              child: ValidationStatusWidget(
                                list: dashboardDataModel,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          UIHelpers.horizontalSpaceSmall,
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: SupportBotColors.blueSecondary.shade100,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const UserValidationWidget()),
                ),
                UIHelpers.verticalSpaceRegular,
                Expanded(
                    flex: 5,
                    child: Container(child: AiQueryEditedAnswerWidget())),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

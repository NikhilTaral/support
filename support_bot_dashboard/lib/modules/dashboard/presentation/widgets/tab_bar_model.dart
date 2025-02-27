import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/pages/ai_query_edited.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/home_page_widget.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/pages/ticket_classification.dart';

enum TypeBarType {
  home,
  ticketClassification,
  aIQueryAnswer,
}

class TabBarWidget {
  final String? pipelineName;
  final List<String>? piplineId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? title;
  final Widget view;
  final IconData? icon;
  final String? svgPath;

  final TypeBarType type;

  const TabBarWidget({
    this.endDate,
    this.pipelineName,
    this.piplineId,
    this.startDate,
    this.title,
    required this.view,
    required this.type,
    this.icon,
    this.svgPath,
  });

  static List<TabBarWidget> organizationItemList(BuildContext context,
      {String? pipelineName,
      String? piplineId,
      DateTime? startDate,
      DateTime? endDate}) {
    final s = serviceLocator<S>();
    List<TabBarWidget> tabBarList = [];

    tabBarList.add(
      TabBarWidget(
        svgPath: 'assets/icons/House.svg',
        view: SizedBox(
          width: double.infinity,
          child: HomePageWidget(),
        ),
        type: TypeBarType.home,
      ),
    );

    tabBarList.add(
      TabBarWidget(
        title: s.ticketClassification,
        view: SizedBox(
          width: double.infinity,
          child: TicketClassification(
            pipelineName: pipelineName ?? "",
            piplineId: piplineId,
            endDate: endDate ?? DateTime.now(),
            startDate: startDate ?? DateTime.now(),
          ),
        ),
        type: TypeBarType.ticketClassification,
      ),
    );

    tabBarList.add(
      TabBarWidget(
        title: s.aiQueryAnswer,
        view: SizedBox(
          width: double.infinity,
          child: AIQueryEditedScreen(
            pipelineName: pipelineName ?? "",
            piplineId: piplineId,
            endDate: endDate ?? DateTime.now(),
            startDate: startDate ?? DateTime.now(),
          ),
        ),
        type: TypeBarType.aIQueryAnswer,
      ),
    );

    return tabBarList;
  }
}

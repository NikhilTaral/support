import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ai_query_answer_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/home_page_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ticket_classification_pluto_gride_widget.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';

enum TypeBarType {
  home,
  ticketClassification,
  aIQueryAnswer,
}

class TabBarWidget {
  final String? title;
  final Widget view;
  final IconData? icon;

  final TypeBarType type;

  const TabBarWidget({
    this.title,
    required this.view,
    required this.type,
    this.icon,
  });

  static List<TabBarWidget> organizationItemList(BuildContext context) {
    List<TabBarWidget> tabBarList = [];

    tabBarList.add(
      const TabBarWidget(
        icon: SupportBotIcons.home,
        view: SizedBox(
          width: double.infinity,
          child: HomePageWidget(),
        ),
        type: TypeBarType.home,
      ),
    );

    tabBarList.add(
      TabBarWidget(
        title: "Ticket Classification",
        view: SizedBox(
          width: double.infinity,
          child: TicketClassificationPlutoGrideWidget(),
        ),
        type: TypeBarType.ticketClassification,
      ),
    );

    tabBarList.add(
      const TabBarWidget(
        title: "AI Query Edited",
        view: SizedBox(
          width: double.infinity,
          child: AiQueryAnswerWidget(),
        ),
        type: TypeBarType.aIQueryAnswer,
      ),
    );

    return tabBarList;
  }
}

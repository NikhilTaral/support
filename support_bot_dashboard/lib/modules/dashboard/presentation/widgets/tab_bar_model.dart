import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/pages/ai_query_edited.dart';
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
  final String? svgPath;

  final TypeBarType type;

  const TabBarWidget({
    this.title,
    required this.view,
    required this.type,
    this.icon,
    this.svgPath,
  });

  static List<TabBarWidget> organizationItemList(BuildContext context) {
    List<TabBarWidget> tabBarList = [];

    tabBarList.add(
      const TabBarWidget(
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
        title: "AI Query Answer",
        view: SizedBox(
          width: double.infinity,
          child: AIQueryEditedScreen(),
        ),
        type: TypeBarType.aIQueryAnswer,
      ),
    );

    return tabBarList;
  }
}

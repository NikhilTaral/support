import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/pages/ai_query_edited.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/home_page_widget.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/pages/ticket_classification.dart';

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
    final s = serviceLocator<S>();
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
        title:s.ticketClassification,
        view: const SizedBox(
          width: double.infinity,
          child: TicketClassification(),
        ),
        type: TypeBarType.ticketClassification,
      ),
    );

    tabBarList.add(
       TabBarWidget(
        title:s.aiQueryAnswer,
        view: const SizedBox(
          width: double.infinity,
          child: AIQueryEditedScreen(),
        ),
        type: TypeBarType.aIQueryAnswer,
      ),
    );

    return tabBarList;
  }
}

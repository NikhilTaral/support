import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/tab_index_bloc/tab_index_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/tab_bar_model.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';

class MyOrganizationNavBar extends StatefulWidget {
  final int index;
  const MyOrganizationNavBar({
    super.key,
    required this.index,
  });

  @override
  State<MyOrganizationNavBar> createState() => _MyOrganizationNavBarState();
}

class _MyOrganizationNavBarState extends State<MyOrganizationNavBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late List<TabBarWidget> organizationItems;

  @override
  void initState() {
    super.initState();

    final bloc = BlocProvider.of<TabIndexBloc>(context, listen: false);
    organizationItems = TabBarWidget.organizationItemList(context);

    _tabController = TabController(
      vsync: this,
      length: organizationItems.length,
      initialIndex: bloc.currentIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    organizationItems = TabBarWidget.organizationItemList(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: BlocBuilder<TabIndexBloc, TabIndexState>(
        builder: (context, state) {
          final selectedIndex =
              BlocProvider.of<TabIndexBloc>(context).currentIndex;

          return TabBar(
            tabAlignment: TabAlignment.start,
            controller: _tabController,
            isScrollable: true,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            labelColor: SupportBotColors.white,
            indicator: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              color: SupportBotColors.bluePrimary,
            ),
            indicatorColor: Colors.transparent,
            labelStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            onTap: (value) {
              if (value != selectedIndex) {
                BlocProvider.of<TabIndexBloc>(context)
                    .add(TabIndexChangedEvent(currentIndex: value));
              }
            },
            labelPadding: const EdgeInsets.only(left: 30),
            indicatorPadding: EdgeInsets.zero,
            tabs: List.generate(
              organizationItems.length,
              (index) => _buildTabItem(index, selectedIndex ?? 0),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabItem(int index, int selectedIndex) {
    final item = organizationItems[index];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (item.icon != null) Icon(item.icon),
          if (item.title != null)
            Text(
              item.title ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
        ],
      ),
    );
  }
}

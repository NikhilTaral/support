import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/header/nav_bar.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/tab_index_bloc/tab_index_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/home_filters_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/navbar_widget.dart';

import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/tab_bar_model.dart';

class DashboardDesktopView extends StatelessWidget {
  final int? index;

  const DashboardDesktopView({
    super.key,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabIndexBloc, TabIndexState>(
      builder: (context, state) {
        return _headerView(context: context);
      },
    );
  }

  Widget _headerView({
    required BuildContext context,
  }) {
    return _desktopContentView(
      context: context,
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
    );
  }

  Widget _desktopContentView({
    required BuildContext context,
    required EdgeInsetsGeometry padding,
  }) {
    int selectedIndex = (index != null && index! >= 0)
        ? index!
        : BlocProvider.of<TabIndexBloc>(context).currentIndex;

    var incomeItems = TabBarWidget.organizationItemList(context);

    if (incomeItems.isEmpty) {
      return const Center(child: Text('No items available.'));
    }

    if (selectedIndex < 0 || selectedIndex >= incomeItems.length) {
      selectedIndex = 0;
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavBar(
                showPopArrow: false,
                navigateTo: () {},
                text: "",
              ),
              Padding(
                padding: padding,
                child: HomeFiltersWidget(),
              ),
              MyOrganizationNavBar(index: selectedIndex),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: incomeItems[selectedIndex].view,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

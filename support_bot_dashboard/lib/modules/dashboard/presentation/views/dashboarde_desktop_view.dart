import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/header/nav_bar.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/index_bloc/index_bloc.dart';
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
    return BlocBuilder<IndexBloc, IndexState>(
      builder: (context, state) {
        if (state is IndexSucssesState) {}
        return _headerView(context: context);
      },
    );
  }

  Widget _headerView({
    required BuildContext context,
  }) {
    return _desktopContentView(
      context: context,
      padding: const EdgeInsets.fromLTRB(16.0, 20, 16.0, 0),
    );
  }

  Widget _desktopContentView({
    required BuildContext context,
    required EdgeInsetsGeometry padding,
  }) {
    int selectedIndex = (index != null && index! >= 0)
        ? index!
        : BlocProvider.of<IndexBloc>(context).currentIndex;
    var incomeItems = TabBarWidget.organizationItemList(context);

    if (incomeItems.isEmpty) {
      return Center(child: Text('No items available.'));
    }

    if (selectedIndex < 0 || selectedIndex >= incomeItems.length) {
      selectedIndex = 0;
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavBar(
            showPopArrow: false,
            navigateTo: () {},
            text: "",
          ),
          HomeFiltersWidget(),
          MyOrganizationNavBar(
            index: selectedIndex,
          ),
          const SizedBox(height: 10),
          TabBarWidget.organizationItemList(context)[selectedIndex].view,
        ],
      ),
    );
  }
}

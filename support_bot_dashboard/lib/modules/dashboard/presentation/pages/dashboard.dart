import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/views/dashboard_desktop_view.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/views/dashboard_mobile_view.dart';
import 'package:support_bot_dashboard/responsive.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        mobile: DashboardMobileView(),
        tablet: DashboardDesktopView(),
        desktop: DashboardDesktopView(),
      ),
    );
  }
}

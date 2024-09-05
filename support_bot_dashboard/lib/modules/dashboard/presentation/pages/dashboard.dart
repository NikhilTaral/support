import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/views/dashboard_desktop_view.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/views/dashboard_mobile_view.dart';
import 'package:support_bot_dashboard/responsive.dart';

class Dashboard extends StatelessWidget {
   Dashboard({super.key});
  String pipeline = '11257490';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: DashboardMobileView(),
        tablet: DashboardDesktopView(pipeline: pipeline,),
        desktop: DashboardDesktopView(pipeline: pipeline,),
      ),
    );
  }
}

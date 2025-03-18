import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/landing_page/presentation/view/Landing_page_mobile_view.dart';
import 'package:support_bot_dashboard/modules/landing_page/presentation/view/landing_page_desktop_view.dart';
import 'package:support_bot_dashboard/responsive.dart';
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: const LandingPageMobileView(),
        tablet: LandingPageDesktopView(),
        desktop: LandingPageDesktopView(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/views/dashboard_desktop_view.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/views/dashboard_mobile_view.dart';
import 'package:support_bot_dashboard/responsive.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<DashboardBloc>()..add(FetchDataEvent()),
      child: const Scaffold(
        body: Responsive(
          mobile: DashboardMobileView(),
          tablet: DashboardDesktopView(),
          desktop: DashboardDesktopView(),
        ),
      ),
    );
  }
}

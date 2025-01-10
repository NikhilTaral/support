import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/header/nav_bar.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/tab_index_bloc/tab_index_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/views/dashboard_mobile_view.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/views/dashboard_desktop_view.dart';
import 'package:support_bot_dashboard/responsive.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  String pipeline = '11257490';
  String selectedPipelineId = '11257490';
  bool isAIAnswer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TabIndexBloc(),
          ),
        ],
        child: const Responsive(
          mobile: DashboardMobileView(),
          tablet: DashboardDesktopView(),
          desktop: DashboardDesktopView(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:support_bot_dashboard/config/router/go_route/app_route_constant.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/pages/dashboard.dart';
import 'package:support_bot_dashboard/modules/landing_page/presentation/page/landing_page.dart';
import 'package:support_bot_dashboard/modules/login_v3/presentation/pages/v3_login_screen.dart';
import 'package:support_bot_dashboard/utils/service/auth/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyAppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: MyAppRouteName.main,
        path: '/',
        pageBuilder: (context, state) =>
            const MaterialPage(child: LandingPage()),
      ),
      GoRoute(
        path: "/login",
        pageBuilder: (context, state) =>
            const MaterialPage(child: V3LoginScreen()),
      ),
      GoRoute(
        name: MyAppRouteName.dashboard,
        path: '/dashboard',
        pageBuilder: (context, state) {
          final pipelineName = state.queryParams["pipelineName"];
          final startDateString = state.queryParams['startDate'];
          final endDateString = state.queryParams['endDate'];
          final pipelineId = state.queryParams['pipelineId']?.split(",");

          DateTime? startDate = startDateString != null
              ? DateTime.tryParse(startDateString)
              : null;
          DateTime? endDate =
              endDateString != null ? DateTime.tryParse(endDateString) : null;

          return MaterialPage(
            child: Dashboard(
              pipelineName: pipelineName,
              pipelineId: pipelineId,
              startDate: startDate,
              endDate: endDate,
            ),
          );
        },
      ),
    ],
    redirect: (context, state) async {
      var isAuthenticated = await serviceLocator<AuthService>()
          .checkValidToken(); // Use a synchronous check

      final goingToLogin = state.location == "/login";
      final goingToDashboard = state.location == "/dashboard";

      if (!isAuthenticated) {
        return "/login"; // Redirect to login if not authenticated
      } else if (isAuthenticated && goingToLogin) {
        return "/"; // Redirect authenticated users away from login
      }

      return null; // No redirection needed
    },
  );
}

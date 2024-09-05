import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:support_bot_dashboard/config/router/go_route/app_route_constant.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/pages/dashboard.dart';
import 'package:support_bot_dashboard/modules/login_v3/presentation/pages/v3_login_screen.dart';
import 'package:support_bot_dashboard/utils/service/auth/auth_service.dart';

class MyAppRoutes {
  GoRouter router = GoRouter(
      errorPageBuilder: (context, state) =>
          const MaterialPage(child: V3LoginScreen()),
      redirect: (context, state) async {
        return await redirect(context, state);
      },
      routes: [
        GoRoute(
          redirect: redirect,
          name: MyAppRouteName.main,
          path: '/',
          pageBuilder: (context, state) {
            return  MaterialPage(child: Dashboard());
          },
        ),
        GoRoute(
          redirect: redirect,
          path: "/login",
          pageBuilder: (context, state) =>
              const MaterialPage(child: V3LoginScreen()),
        ),
        GoRoute(
          redirect: redirect,
          name: MyAppRouteName.dashboard,
          path: '/dashboard',
          pageBuilder: (context, state) {
            final queryParams = state.queryParams;
            final code = queryParams['code'];
            return  MaterialPage(child: Dashboard());
          },
        ),
      ]);
}

Future<String?> redirect(BuildContext context, GoRouterState state) async {
  var isAuthenticated = await serviceLocator<AuthService>().checkValidToken();
  if (!isAuthenticated) {
    return '/login';
  } else {
    if (state.name == "login" || state.name == null) {
      return '/dashboard';
    } else {
      return null;
    }
  }
}

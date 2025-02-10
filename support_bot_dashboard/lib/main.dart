import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/config/router/go_route/app_route_config.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/utils/log.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    Log.error("Caught error: ${details.exceptionAsString()}");
  };
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Support Bot',
      debugShowCheckedModeBanner: false,
      routeInformationParser: MyAppRoutes.router.routeInformationParser,
      routerDelegate: MyAppRoutes.router.routerDelegate,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: SupportBotColors.white,
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}

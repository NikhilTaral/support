import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:support_bot_dashboard/config/router/go_route/app_route_constant.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/service/auth/auth_service.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class NavBar extends StatelessWidget {
  final bool showPopArrow;
  final VoidCallback navigateTo;
  final String text;

  const NavBar(
      {super.key,
      required this.showPopArrow,
      required this.navigateTo,
      required this.text});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = serviceLocator<AuthService>();
    Future<String?> userName = authService.getUsername();
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: SupportBotColors.blueSecondary.shade200, width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                child: showPopArrow
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: SupportBotColors.blueSecondary.shade500,
                        ),
                        onPressed: navigateTo)
                    : const SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: SupportBotTextstyle.subheadingH5.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<String?>(
              future: userName,
              builder:
                  (BuildContext context, AsyncSnapshot<String?> userName) =>
                      userName.hasData
                          ? _showName(userName.data, context)
                          : LoadingWidget(
                              width: 150,
                              height: 70,
                              borderRadius: BorderRadius.circular(5),
                            ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _onLogoutTapped(context);
            },
            tooltip: 'Logout',
          ),
        ],
      ),
    );
  }
}

Future<void> _onLogoutTapped(context) async {
  await serviceLocator<AuthService>().clearTokens();
  GoRouter.of(context).pushNamed(
    MyAppRouteName.main,
  );
}

Widget _showName(String? name, BuildContext context) {
  final textPainter = TextPainter(
    text: TextSpan(
      text: name,
      style: SupportBotTextstyle.medium.copyWith(fontWeight: FontWeight.w600),
    ),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);
  final textWidth = textPainter.size.width;

  return Container(
    margin: const EdgeInsets.only(right: 10),
    width: textWidth + 70, // Adjust the additional width as needed
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: SupportBotColors.blueSecondary.shade200),
    ),
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          UIHelpers.horizontalSpaceSmall,
          const CircleAvatar(
            radius: 17,
            backgroundImage: AssetImage('assets/images/AI.jpg'),
          ),
          UIHelpers.horizontalSpaceSmall,
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                name ?? "AI Team",
                style: SupportBotTextstyle.medium
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

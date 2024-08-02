import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/gen_assets/assets.gen.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/login_v3/presentation/bloc/v3_login_bloc.dart';
import 'package:support_bot_dashboard/responsive.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/custom_elevated_button.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class V3LoginView extends StatelessWidget {
  const V3LoginView({Key? key = const Key('LoginViewKey')}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<V3LoginBloc>(),
      child: Scaffold(
        backgroundColor: SupportBotColors.blueSecondary,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _contentView(context),
          ),
        ),
      ),
    );
  }

  Widget _contentView(BuildContext context) {
    return BlocBuilder<V3LoginBloc, V3LoginState>(
      builder: (context, state) {
        if (state is V3LoginFailureState) {
          return _logInFields(context, null, null, false);
        } else if (state is V3LoginSuccessState) {
          // _showSuccessPage(context);
          return _logInSuccessView();
        } else if (state is V3LoginInitialState) {
          return _logInFields(context, null, null, false);
        } else {
          // (state is LoginLoading)
          return _logInFields(context, null, null, true);
        }
      },
    );
  }

  Widget _logInSuccessView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _logInFields(
      BuildContext context, String? username, String? userId, bool isLoading) {
    return Responsive(
      key: const Key('LoginScreenResponsive'),
      mobile: _mobileLoginScreen(context, isLoading),
      tablet: _tabletLoginScreen(context, isLoading),
      desktop: _desktopLoginScreen(context, isLoading),
    );
  }

  void _onLogInButtonPressed(BuildContext context) {
    final loginEvent = PerformLogInEvent();
    context.read<V3LoginBloc>().add(loginEvent);
  }

  // void _showSuccessPage(BuildContext context) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Provider.of<AppState>(context, listen: false).completeLogin();
  //   });
  // }

  // bool isAppStoreLinkEnabled() {
  //   return serviceLocator<RemoteConfigService>()
  //       .getBool(RemoteConfigKey.enableLoginAppStoreButtons);
  // }

  _mobileLoginScreen(BuildContext context, bool isLoading) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _logoImage(),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: SupportBotColors.white),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Sign in to your account',
                          style: SupportBotTextstyle.subheadingH4
                              .copyWith(color: SupportBotColors.blueSecondary.shade400)),
                      const SizedBox(height: 45),
                      _logInButton(context, isLoading),
                      const SizedBox(height: 16),
                      // if ("errorMessage" != )
                      //   _displayErrorMessage("errorMessage"),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                        child: Text(
                          'You\'ll use your OKTA username and password to sign in. These are the same username and password you use to sign into other eXp systems.',
                          style: SupportBotTextstyle.description
                              .copyWith(color: SupportBotColors.blueSecondary.shade400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _appStoreLinkView(BuildContext buildContext) {
  //   void goToAppStore(RemoteConfigKey key) {
  //     MobileActionsTools.launchURL(
  //         serviceLocator<RemoteConfigService>().getString(key));
  //   }

  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       InkWell(
  //         onTap: () {
  //           goToAppStore(RemoteConfigKey.googlePlayStoreAppUrl);
  //         },
  //         child: SvgPicture.asset(
  //           'assets/images/login/google-play-link.svg',
  //           width: 155.0,
  //           height: 45.0,
  //         ),
  //       ),
  //       const SizedBox(
  //         width: 20,
  //       ),
  //       InkWell(
  //         onTap: () {
  //           goToAppStore(RemoteConfigKey.appleAppStoreAppUrl);
  //         },
  //         child: SvgPicture.asset(
  //           'assets/images/login/app-store-link.svg',
  //           width: 155.0,
  //           height: 45.0,
  //         ),
  //       )
  //     ],
  //   );
  // }

  Widget _logInButton(BuildContext buildContext, bool isLoading) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: double.infinity,
      ),
      child: isLoading
          ? _logInButtonLoading(buildContext)
          : _logInButtonNotLoading(buildContext),
    );
  }

  Widget _logInButtonNotLoading(BuildContext buildContext) {
    return CustomElevatedButton(
        backgroundColor: SupportBotColors.bluePrimary,
        borderRadius: 20,
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          _onLogInButtonPressed(buildContext);
        },
        child: const Text('Sign In'));
  }

  Widget _logInButtonLoading(BuildContext buildContext) {
    return ElevatedButton.icon(
      icon: const CircularProgressIndicator(color: Color(0xFFd6721b)),
      label: const Text(''),
      onPressed: null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 15.0,
      ),
    );
  }

  _tabletLoginScreen(BuildContext context, bool isLoading) {
    return Center(
      child: SizedBox(
        width: 450,
        child: _mobileLoginScreen(context, isLoading),
      ),
    );
  }

  _desktopLoginScreen(BuildContext context, bool isLoading) {
    return Center(
      child: SizedBox(
        width: 450,
        child: _mobileLoginScreen(context, isLoading),
      ),
    );
  }

  Widget _logoImage() {
    return Container(
        padding: const EdgeInsets.all(30.0),
        child: Assets.images.login.myExpLogoNew.svg(
          width: 85.8,
          height: 59.4,
        ));
  }

  Widget _displayErrorMessage(String? error) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: SupportBotColors.danger,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4), topLeft: Radius.circular(4)),
            ),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(right: 8.0),
            child: const Icon(
              SupportBotIcons.closeCircle,
              // ExpV3Icons.exclamationCircle,
              size: 24.0,
              color: Colors.white,
            ),
          ),
          Flexible(
            child: Text(
              error ?? 'Unable to sign in.',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}

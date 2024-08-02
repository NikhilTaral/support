import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:support_bot_dashboard/core/network/custom_exception.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/utils/email_validation.dart';
import 'package:support_bot_dashboard/utils/log.dart';
import 'package:support_bot_dashboard/utils/service/auth/auth_service.dart';
import 'package:support_bot_dashboard/utils/service/auth/onboarding_auth_result.dart';
part 'v3_onboarding_login_event.dart';
part 'v3_onboarding_login_state.dart';

class V3OnboardingLoginBloc
    extends Bloc<V3OnboardingLoginEvent, V3OnboardingLoginState> {
  V3OnboardingLoginBloc() : super(V3OnboardingLoginInitialState()) {
    on<LogInAgent>(_onLogInAgent);
    on<LogInResetJoining>(_onResetJoining);
    on<LogInJoiningComplete>(_onLogInJoiningComplete);
    on<LogInJoiningFailed>(_onLogInJoiningFailed);
    on<ClearLoginError>(_onClearLoginError);
  }
  bool _isSigningInWeb = false;

  Future<void> checkForSignInLink() async {

      return _checkForSignInLinkWeb();

  }

  Future<void> _checkForSignInLinkWeb() async {
    if (_isSigningInWeb) return;

    _isSigningInWeb = true;

    final link = Uri.base;
    final email = link.queryParameters["email"];
    final name = link.queryParameters["name"];
    final isJoin = link.queryParameters["join"];

    if (email == null) {
      _isSigningInWeb = false;
      return;
    }

    // Check if join link to direct to join bot
    if (isJoin?.toLowerCase() == "true") {
      _isSigningInWeb = false;
      add(
        LogInJoinBotLink(
          email: email,
          link: link.toString(),
          shouldValidate: false,
        ),
      );
      return;
    } else {
      // Handle onboarding link
      if (name == null) {
        _isSigningInWeb = false;
        return;
      }
      add(
        LogInJoiningSignInLink(
          email: email,
          name: name,
          link: link.toString(),
          shouldValidate: false,
        ),
      );
      _isSigningInWeb = false;
      return;
    }
  }

  // Future<void> _checkForSignInLink() async {
  //   try {
  //     // _deepLinkSubscription ??=
  //     //     FirebaseDynamicLinks.instance.onLink.listen((event) {
  //     //   final deepLink = event.link;
  //     //   _handleDeepLink(
  //     //     link: deepLink,
  //     //   );
  //     // });

  //     // final PendingDynamicLinkData? initialLink =
  //     //     await FirebaseDynamicLinks.instance.getInitialLink();
  //     final Uri? deepLink = initialLink?.link;

  //     if (deepLink != null) {
  //       _handleDeepLink(link: deepLink);
  //     }
  //   } catch (e) {
  //     Log.error("OnboardingLoginBloc failed to handle link with error: $e");
  //   }
  // }

  Future<void> _handleDeepLink({
    required Uri? link,
  }) async {
    if (link == null) {
      Log.debug("OnboardingLoginBloc received null link");
      return;
    }

    final url = link.queryParameters["continueUrl"];
    if (url == null) {
      Log.debug(
          "OnboardingLoginBloc received null continueUrl ${link.toString()}");
      return;
    }

    final continueUri = Uri.tryParse(url);
    if (continueUri == null) {
      Log.debug(
          "OnboardingLoginBloc failed to parse continueUri ${link.toString()}");
      return;
    }

    final email = continueUri.queryParameters["email"];

    if (email == null) {
      Log.debug(
          "OnboardingLoginBloc received link ${link.toString()} with null email");
      return;
    }

    if (EmailValidation.validate(email) == false) {
      Log.debug(
          "OnboardingLoginBloc received link $link with invalid email $email");
      return;
    }

    final name = continueUri.queryParameters["name"];

    if (name == null) {
      final isJoin = continueUri.queryParameters["join"]?.toLowerCase();
      if (isJoin == "true") {
        // Handle join bot link
        add(
          LogInJoinBotLink(
            email: email,
            link: link.toString(),
            shouldValidate: true,
          ),
        );
        return;
      }

      Log.debug(
          "OnboardingLoginBloc received link ${link.toString()} with null name");
      return;
    }

    add(
      LogInJoiningSignInLink(
        email: email,
        name: name,
        link: link.toString(),
        shouldValidate: true,
      ),
    );
  }

  FutureOr<void> _onLogInAgent(
      LogInAgent event, Emitter<V3OnboardingLoginState> emit) async {
    final authService = serviceLocator<AuthService>();

    try {
      if (state is V3OnboardingLoginLoadingState) {
        Log.debug("$runtimeType attempted to fetch data while loading");
        return;
      }

      emit(V3OnboardingLoginLoadingState());
      var isAuthenticated = await authService.isAuthenticated();

      if (!isAuthenticated) {
        isAuthenticated = await authService.authenticate();
        if (!isAuthenticated) {
          emit(
            V3OnboardingLoginFailureState(
              message: 'Unable to sign in. ',
            ),
          );
          return;
        }
      }
      emit(V3OnboardingLoginSuccessState());
    } on CustomException {
      emit(
        V3OnboardingLoginFailureState(
          message: 'Unable to sign in. ',
        ),
      );
    } catch (e) {
      Log.debug(e.toString());
      emit(
        V3OnboardingLoginFailureState(
          message: 'Unable to sign in. ',
        ),
      );
    }
  }

  FutureOr<void> _onResetJoining(
      LogInResetJoining event, Emitter<V3OnboardingLoginState> emit) async {
    emit(V3OnboardingLoginInitialState());
  }

  FutureOr<void> _onLogInJoiningComplete(
      LogInJoiningComplete event, Emitter<V3OnboardingLoginState> emit) async {
    emit(OnboardingJoinLoginSuccess());
  }

  FutureOr<void> _onLogInJoiningFailed(
      LogInJoiningFailed event, Emitter<V3OnboardingLoginState> emit) async {
    emit(OnboardingJoinLoginFailed(result: event.result));
  }


  FutureOr<void> _onClearLoginError(
      ClearLoginError event, Emitter<V3OnboardingLoginState> emit) async {
    emit(V3OnboardingLoginInitialState());
  }
}

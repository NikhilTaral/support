part of 'v3_onboarding_login_bloc.dart';

abstract class V3OnboardingLoginState {}

class V3OnboardingLoginInitialState extends V3OnboardingLoginState {}

class V3OnboardingLoginSuccessState extends V3OnboardingLoginState {}

class V3OnboardingLoginFailureState extends V3OnboardingLoginState {
  final String message;

  V3OnboardingLoginFailureState({
    required this.message,
  });
}

class V3OnboardingLoginLoadingState extends V3OnboardingLoginState {}

class V3OnboardingLoginEmptyState extends V3OnboardingLoginState {}

class V3OnboardingLoginActionState extends V3OnboardingLoginState {}

class OnboardingJoinLoginSuccess extends V3OnboardingLoginState {}

class OnboardingJoinBotLoginSuccess extends V3OnboardingLoginState {}

class OnboardingJoinLoginFailed extends V3OnboardingLoginState {
  final OnboardingAuthResult result;
  OnboardingJoinLoginFailed({
    required this.result,
  });
}

class OnboardingJoinEmailSent extends V3OnboardingLoginState {
  final String email;
  OnboardingJoinEmailSent({
    required this.email,
  });
}

part of 'v3_onboarding_login_bloc.dart';

abstract class V3OnboardingLoginEvent {}

class V3OnboardingLoginInitialEvent extends V3OnboardingLoginEvent {}

class LogInAgent extends V3OnboardingLoginEvent {}

class LogInJoining extends V3OnboardingLoginEvent {
  final String email;
  final String name;
  LogInJoining({
    required this.email,
    required this.name,
  });
}

class LogInResetJoining extends V3OnboardingLoginEvent {}

class LogInJoiningComplete extends V3OnboardingLoginEvent {
  final String email;
  final String name;
  LogInJoiningComplete({
    required this.email,
    required this.name,
  });
}

class LogInJoinBotComplete extends V3OnboardingLoginEvent {
  final String email;
  LogInJoinBotComplete({
    required this.email,
  });
}

class LogInJoiningFailed extends V3OnboardingLoginEvent {
  LogInJoiningFailed({
    required this.result,
  });

  final OnboardingAuthResult result;
}

class ClearLoginError extends V3OnboardingLoginEvent {}

class LogInJoiningSignInLink extends V3OnboardingLoginEvent {
  final String email;
  final String name;
  final String link;
  final bool shouldValidate;
  LogInJoiningSignInLink({
    required this.email,
    required this.name,
    required this.link,
    required this.shouldValidate,
  });
}

class LogInJoinBotLink extends V3OnboardingLoginEvent {
  final String email;
  final String link;
  final bool shouldValidate;
  LogInJoinBotLink({
    required this.email,
    required this.link,
    required this.shouldValidate,
  });
}

import 'package:equatable/equatable.dart';

class OnboardingAuthResult extends Equatable {
  const OnboardingAuthResult({
    required this.isSuccess,
    required this.isValidLink,
    required this.isEmailMissingOrInvalid,
    required this.isExpired,
    required this.isDisabled,
    required this.isAlreadyInUse,
  });

  final bool isSuccess;
  final bool isValidLink;
  final bool isEmailMissingOrInvalid;
  final bool isExpired;
  final bool isDisabled;
  final bool isAlreadyInUse;

  @override
  List<Object?> get props => [
        isSuccess,
        isValidLink,
        isEmailMissingOrInvalid,
        isExpired,
        isDisabled,
        isAlreadyInUse,
      ];
}

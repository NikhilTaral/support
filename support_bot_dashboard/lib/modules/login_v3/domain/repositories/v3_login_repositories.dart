import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

abstract class V3LoginRepositories {
  // Future<Either<Failure, dynamic>> sendJoinEmail(String email, String name);
  Future<Either<Failure, dynamic>> saveOnboardingEmailAndName(
      String email, String name);
  // Future<Either<Failure, dynamic>> saveJoinBotEmail(String email);
}

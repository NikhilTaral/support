import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/login_v3/domain/repositories/v3_login_repositories.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage_key.dart';

class V3LoginRepositoryImpl implements V3LoginRepositories {
  @override
  Future<Either<Failure, dynamic>> saveOnboardingEmailAndName(
      String email, String name) async {
    final localStorage = serviceLocator<LocalStorage>();
    final isEmailStored = await localStorage.setString(email,
        localStorageKey: LocalStorageKey.onboardingEmail);
    final isNameStored = await localStorage.setString(name,
        localStorageKey: LocalStorageKey.onboardingName);
    bool saveOnboardingEmailAndNameResponse = isEmailStored && isNameStored;

    if (saveOnboardingEmailAndNameResponse == true) {
      return Right(saveOnboardingEmailAndNameResponse);
    } else if (saveOnboardingEmailAndNameResponse == false) {
      return Left(ServerFailure(message: 'No response from server'));
    } else {
      return Left(ServerFailure(message: 'No response from server'));
    }
  }
}

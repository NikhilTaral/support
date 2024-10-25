import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_user_settings_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class DashboardGetUserSettingsUsecase implements UseCaseOneInput{
  @override
  Future<Either<Failure, dynamic>> invoke(
       email) async {
    return await serviceLocator<GetUserSettingsRepository>()
        .getUserSettings(email);
  }
}
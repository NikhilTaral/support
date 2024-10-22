
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_user_settings_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

class DashboardGetUserSettingsRepoImpl extends GetUserSettingsRepository{
  @override
  Future<Either<Failure, dynamic>> getUserSettings(String? email) async{
    final ApiProvider _apiProvider = serviceLocator<ApiProvider>();

    dynamic response;
    response = await _apiProvider.getData(
      url: 'dashboard/getUserSettings',
      body: {
        "emailId": email
      },
    );
    if (response == null) {
      return Left(ServerFailure(message: 'No response from server'));
    }
    return Right(response);
  }

}
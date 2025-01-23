import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/validation_status_repository.dart';

class ValidationStatusUsecase {
  Future<Either<Failure, dynamic>> invoke(
      dashboardChartDataInitialRequestModel) async {
    return await serviceLocator<ValidationStatusRepository>()
        .validationStatus(dashboardChartDataInitialRequestModel);
  }
}

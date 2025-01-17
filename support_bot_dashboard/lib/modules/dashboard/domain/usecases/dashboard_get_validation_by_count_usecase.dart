import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_validation_by_count_repository.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

class DashboardGetValidationByCountUsecase {
  Future<Either<Failure, dynamic>> invoke(
      dashboardChartDataInitialRequestModel) async {
    return await serviceLocator<GetValidationByCountRepository>()
        .getValidationByCount(dashboardChartDataInitialRequestModel);
  }
}

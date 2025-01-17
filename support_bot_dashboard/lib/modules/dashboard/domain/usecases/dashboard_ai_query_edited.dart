import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_ai_edited_repository.dart';

class DashboardAiQueryEditedUsecase {
  Future<Either<Failure, dynamic>> invoke(
      dashboardChartDataInitialRequestModel) async {
    return await serviceLocator<DashboardGetAiEditedRepository>()
        .getAiEdited(dashboardChartDataInitialRequestModel);
  }
}

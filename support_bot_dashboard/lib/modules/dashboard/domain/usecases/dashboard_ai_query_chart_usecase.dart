import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_ai_query_chart_repository.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

class DashboardAiQueryChartUsecase {
  Future<Either<Failure, dynamic>> invoke(
      dashboardChartDataInitialRequestModel) async {
    return await serviceLocator<DashboardAiQueryChartDataRepository>()
        .getAiQueryChartData(dashboardChartDataInitialRequestModel);
  }
}

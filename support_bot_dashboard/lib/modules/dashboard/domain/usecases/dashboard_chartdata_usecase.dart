import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_chart_data_repository.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

class DashboardChartdataUsecase {
  Future<Either<Failure, dynamic>> invoke(
      dashboardChartDataInitialRequestModel) async {
    return await serviceLocator<DashboardChartDataRepository>()
        .getDashboardChartData(dashboardChartDataInitialRequestModel);
  }
}

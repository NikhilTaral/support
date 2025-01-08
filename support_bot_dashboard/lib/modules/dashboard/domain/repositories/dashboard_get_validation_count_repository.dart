import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_Initial_request_model.dart';

abstract class GetValidationCountRepository {
  Future<Either<Failure, dynamic>> getValidationCount(
      DashboardChartDataInitialRequestModel?
          dashboardChartDataInitialRequestModel);
}

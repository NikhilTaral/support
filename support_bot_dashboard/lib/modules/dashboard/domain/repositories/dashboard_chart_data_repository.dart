import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_request_model.dart';

abstract class DashboardChartDataRepository {
  Future<Either<Failure, dynamic>> getDashboardAnswerData(
      DashboardAnswerDataInitialRequestModel?
          dashboardChartDataInitialRequestModel);
}

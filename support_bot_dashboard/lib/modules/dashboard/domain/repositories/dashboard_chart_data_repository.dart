import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

abstract class DashboardChartDataRepository {
  Future<Either<Failure, dynamic>> getDashboardAnswerData(
      DashboardAnswerDataInitialRequestModel?
          dashboardChartDataInitialRequestModel);
}

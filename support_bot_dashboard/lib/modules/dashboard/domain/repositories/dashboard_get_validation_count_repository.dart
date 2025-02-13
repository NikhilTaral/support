import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

abstract class GetValidationCountRepository {
  Future<Either<Failure, dynamic>> getValidationCount(
      DashboardAnswerDataInitialRequestModel?
          dashboardChartDataInitialRequestModel);
}

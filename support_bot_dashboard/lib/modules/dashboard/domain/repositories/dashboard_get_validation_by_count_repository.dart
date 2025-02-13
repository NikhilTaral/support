import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
abstract class GetValidationByCountRepository {
  Future<Either<Failure, dynamic>> getValidationByCount(
      DashboardAnswerDataInitialRequestModel?
          dashboardAnswerDataInitialRequestModel);
}

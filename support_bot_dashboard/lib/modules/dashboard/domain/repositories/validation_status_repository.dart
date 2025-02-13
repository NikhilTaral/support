import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

abstract class ValidationStatusRepository {
  Future<Either<Failure, dynamic>> validationStatus(
      DashboardAnswerDataInitialRequestModel?
          dashboardAnswerDataInitialRequestModel);
}

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
abstract class DashboardAiQueryAnswerDataRepository {
  Future<Either<Failure, dynamic>> getAiQueryAnswerData(
    DashboardAnswerDataInitialRequestModel?
        dashboardAnswerDataInitialRequestModel,
  );
}

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

abstract class DashboardGetAiEditedRepository {
  Future<Either<Failure, dynamic>> getAiEdited(
      DashboardAnswerDataInitialRequestModel?
          dashboardAnswerDataInitialRequestModel);
}

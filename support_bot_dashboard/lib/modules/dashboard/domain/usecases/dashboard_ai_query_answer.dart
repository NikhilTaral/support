import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_ai_query_answer_repository.dart';

class DashboardAiQueryAnswerUsecase {
  Future<Either<Failure, dynamic>> invoke(
      dashboardAnswerDataInitialRequestModel) async {
    return await serviceLocator<DashboardAiQueryAnswerDataRepository>()
        .getAiQueryAnswerData(dashboardAnswerDataInitialRequestModel);
  }
}

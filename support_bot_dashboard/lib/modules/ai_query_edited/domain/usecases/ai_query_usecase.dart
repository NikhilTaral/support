import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/domain/repositories/ai_query_answer_repo.dart';

class AiQueryUsecase {
  Future<Either<Failure, dynamic>> invoke(
      dashboardAnswerDataInitialRequestModel) async {
    return await serviceLocator<AiQueryDataRepository>()
        .aiQueryAnswerData(dashboardAnswerDataInitialRequestModel);
  }
}

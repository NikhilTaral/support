import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/data/model/add_answer_validation_request_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/data/model/update_ai_answer_request_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/domain/repositories/ai_query_answer_repo.dart';

class AiQueryUsecase {
  Future<Either<Failure, dynamic>> invoke(
      dashboardAnswerDataInitialRequestModel) async {
    return await serviceLocator<AiQueryDataRepository>()
        .aiQueryAnswerData(dashboardAnswerDataInitialRequestModel);
  }
}

class UpdateAiAnswerUsecase {
  Future<Either<Failure, dynamic>> invoke(
      UpdateAiAnswerRequestModel updateAiAnswerRequestModel) async {
    return await serviceLocator<AiQueryDataRepository>()
        .updateAiAnswer(updateAiAnswerRequestModel);
  }
}

class AddAnswerValidationUsecase {
  Future<Either<Failure, dynamic>> invoke(
      AddAnswerValidationRequestModel addAnswerValidationRequestModel) async {
    return await serviceLocator<AiQueryDataRepository>()
        .addAnswerValidation(addAnswerValidationRequestModel);
  }
}

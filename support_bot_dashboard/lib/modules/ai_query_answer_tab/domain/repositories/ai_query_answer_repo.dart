import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/data/model/add_answer_validation_request_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/data/model/update_ai_answer_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_request_model.dart';

abstract class AiQueryDataRepository {
  Future<Either<Failure, dynamic>> aiQueryAnswerData(
    DashboardAnswerDataInitialRequestModel?
        dashboardAnswerDataInitialRequestModel,
  );

  Future<Either<Failure, dynamic>> updateAiAnswer(
    UpdateAiAnswerRequestModel? updateAiAnswerRequestModel,
  );

  Future<Either<Failure, dynamic>> addAnswerValidation(
    AddAnswerValidationRequestModel? addAnswerValidationRequestModel,
  );
}

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/data/model/add_answer_validation_request_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/data/model/update_ai_answer_request_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/domain/repositories/ai_query_answer_repo.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_initial_request_model.dart';

class AiQueryAnswerRepoImpl extends AiQueryDataRepository {
  final s = serviceLocator<S>();
  @override
  Future<Either<Failure, dynamic>> aiQueryAnswerData(
      DashboardAnswerDataInitialRequestModel?
          dashboardAnswerDataInitialRequestModel) async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
          url: 'dashboard/getAIResponse',
          body: dashboardAnswerDataInitialRequestModel?.toJson());

      if (response is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      }

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateAiAnswer(
      UpdateAiAnswerRequestModel? updateAiAnswerRequestModel) async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
          url: 'dashboard/updateAIAnswer',
          body: updateAiAnswerRequestModel?.toJson());
      if (response == null) {
        return Left(ServerFailure(message: 'No response from server'));
      }
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
    }
  }

  @override
  Future<Either<Failure, dynamic>> addAnswerValidation(
      AddAnswerValidationRequestModel? addAnswerValidationRequestModel) async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
          url: 'dashboard/addAnswerValidation',
          body: addAnswerValidationRequestModel?.toJson());
      if (response == null) {
        return Left(ServerFailure(message: 'No response from server'));
      }
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
    }
  }
}

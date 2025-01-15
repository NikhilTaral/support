import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/domain/repositories/ai_query_answer_repo.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_Initial_request_model.dart';

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
        return Left(ServerFailure(message: s.aPIErrorMsg));
      }

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsg));
    }
  }
}

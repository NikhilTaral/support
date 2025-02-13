import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_initial_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_ai_edited_repository.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

class DashboardGetAiEditedRepoImpl extends DashboardGetAiEditedRepository {
  final s = serviceLocator<S>();
  @override
  Future<Either<Failure, dynamic>> getAiEdited(
      DashboardAnswerDataInitialRequestModel?
          dashboardAnswerDataInitialRequestModel) async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
          url: 'dashboard/getAnsEditedCount',
          body: dashboardAnswerDataInitialRequestModel?.toJson());
      if (response is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      }
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
    }
  }
}

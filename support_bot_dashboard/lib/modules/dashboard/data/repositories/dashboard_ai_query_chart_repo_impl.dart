import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_ai_query_chart_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_Initial_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_ai_query_answer_repository.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

class DashboardAiQueryAnswerRepoImpl
    extends DashboardAiQueryAnswerDataRepository {
  final s = serviceLocator<S>();
  @override
  Future<Either<Failure, dynamic>> getAiQueryAnswerData(
      DashboardAnswerDataInitialRequestModel?
          dashboardAnswerDataInitialRequestModel) async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
          url: 'dashboard/getAnswerCount',
          body: dashboardAnswerDataInitialRequestModel?.toJson());

      final model =
          dashboardAiQueryChartResponseModelFromJson(jsonEncode(response));
      if (model is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsg));
      }

      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsg));
    }
  }
}

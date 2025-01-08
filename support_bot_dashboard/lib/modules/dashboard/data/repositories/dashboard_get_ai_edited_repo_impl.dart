import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_Initial_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_ai_edited_repository.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

class DashboardGetAiEditedRepoImpl extends DashboardGetAiEditedRepository {
  final s = serviceLocator<S>();
  @override
  Future<Either<Failure, dynamic>> getAiEdited(
      DashboardChartDataInitialRequestModel?
          dashboardChartDataInitialRequestModel) async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
          url: 'dashboard/getAnsEditedCount',
          body: dashboardChartDataInitialRequestModel?.toJson());
      final model = dashboardChartResponseModelFromJson(jsonEncode(response));
      if (model is Left) {
        return Left(ServerFailure(message:  s.aPIErrorMsg));
      }
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message:  s.aPIErrorMsg));
    }
  }
}

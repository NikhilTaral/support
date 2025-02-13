import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_initial_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/get_validation_by_count_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_validation_by_count_repository.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

class DashboardGetValidationByCountRepoImpl
    extends GetValidationByCountRepository {
  final s = serviceLocator<S>();
  @override
  Future<Either<Failure, dynamic>> getValidationByCount(
      DashboardAnswerDataInitialRequestModel?
          dashboardAnswerDataInitialRequestModel) async {
    try {
      if (dashboardAnswerDataInitialRequestModel == null) {
        return Left(ServerFailure(message: 'Request model is null'));
      }
      final response = await serviceLocator<ApiProvider>().getData(
        url: 'dashboard/getValidatedByCount',
        body: dashboardAnswerDataInitialRequestModel.toJson(),
      );
      final model =
          getValidationByCountResponseModelFromJson(jsonEncode(response));
      if (model is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      }
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
    }
  }
}

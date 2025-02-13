import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/validation_status_responset_model.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/validation_status_repository.dart';

class ValidationStatusRepoImpl extends ValidationStatusRepository {
  final s = serviceLocator<S>();
  @override
  Future<Either<Failure, dynamic>> validationStatus(
      DashboardAnswerDataInitialRequestModel?
          dashboardAnswerDataInitialRequestModel) async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
        url: 'dashboard/getValidationCount',
        body: dashboardAnswerDataInitialRequestModel?.toJson(),
      );
      final model =
          validationStatusResponsetModelFromJson(jsonEncode(response));
      if (model is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      } else {
        return Right(model);
      }
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
    }
  }
}

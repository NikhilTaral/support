
import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/ai_accuracy_and_validation_trends_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/ai_accuracy_and_validation_trends_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/ai_accuracy_and_validation_trends_respository.dart';

class AiAccuracyAndValidationTrendsRepoImpl
    extends AiAccuracyAndValidationTrendsRespository {
  final s = serviceLocator<S>();
  @override
  Future<Either<Failure, dynamic>> aiAccuracyAndValidationTrends(
      AiAccuracyAndValidationTrendsRequestModel?
          aiAccuracyAndValidationTrendsRequestModel) async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
          url: 'dashboard/getAnswerCount',
          body: aiAccuracyAndValidationTrendsRequestModel?.toJson());

      final model =
          aiAccuracyAndValidationTrendsResponseModelFromJson(jsonEncode(response));
      if (model is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      }

      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
    }
  }
}

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/ai_accuracy_and_validation_trends_respository.dart';

class AiAccuracyAndValidationTrendsUsecase {
  Future<Either<Failure, dynamic>> invoke(
      aiAccuracyAndValidationTrendsRequestModel) async {
    return await serviceLocator<AiAccuracyAndValidationTrendsRespository>()
        .aiAccuracyAndValidationTrends(
            aiAccuracyAndValidationTrendsRequestModel);
  }
}

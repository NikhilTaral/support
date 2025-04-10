import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/ai_accuracy_and_validation_trends_request_model.dart';

abstract class AiAccuracyAndValidationTrendsRespository {
  Future<Either<Failure, dynamic>> aiAccuracyAndValidationTrends(
    AiAccuracyAndValidationTrendsRequestModel?
        aiAccuracyAndValidationTrendsRequestModel,
  );

}

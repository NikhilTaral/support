import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/get_ai_response_stat_request_model.dart';

abstract class GetAiResponseStatRepository {
  Future<Either<Failure, dynamic>> getAiResponseStat(GetAiResponseStatRequestModel getAiResponseStatRequestModel);
}

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/get_ai_response_stat_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/get_ai_response_stat_repository.dart';

class GetAiResponseStatUsecase {
  Future<Either<Failure, dynamic>> invoke(GetAiResponseStatRequestModel getAiResponseStatRequestModel) async {
    return await serviceLocator<GetAiResponseStatRepository>().getAiResponseStat(getAiResponseStatRequestModel);
  }
}

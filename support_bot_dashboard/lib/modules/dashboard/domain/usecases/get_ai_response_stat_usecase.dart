import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/use_case/use_case.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/get_ai_response_stat_repository.dart';

class GetAiResponseStatUsecase extends UseCaseOneInput{
  @override
  Future<Either<Failure, dynamic>> invoke(getAiResponseStatRequestModel) async {
    return await serviceLocator<GetAiResponseStatRepository>().getAiResponseStat(getAiResponseStatRequestModel);
  }
}

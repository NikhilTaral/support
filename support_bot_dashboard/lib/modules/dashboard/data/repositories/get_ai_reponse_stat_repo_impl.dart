import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/log.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/modules/dashboard/common/get_ai_response_model_mapper.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/get_ai_response_stat_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/get_ai_response_stat_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/get_ai_response_stat_repository.dart';


class GetAiResponseStatRepoImpl extends GetAiResponseStatRepository {
  final s = serviceLocator<S>();
  @override
  Future<Either<Failure, dynamic>> getAiResponseStat(GetAiResponseStatRequestModel getAiResponseStatRequestModel) async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
        url: 'dashboard/getAIResponseStats',
        body: getAiResponseStatRequestModel.toJson(),
      );
      if (response is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      } else {
        final model = getAiResponseStatFromJson(jsonEncode(response));
        return Right(model.toAttributeModel());
      }
    } catch (e) {
      Log.error("Error in getAiResponseStat method $e");
      return Left(ServerFailure(message: s.aPIErrorMsgText));
    }
  }
}

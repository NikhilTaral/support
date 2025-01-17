import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/get_all_pipelines_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/get_all_pipelines_repository.dart';

class GetAllPipelinesRepoImpl extends GetAllPipelinesRepository {
  final s = serviceLocator<S>();

  @override
  Future<Either<Failure, dynamic>> getAllPipeline() async {
   try {
       final dynamic response = await serviceLocator<ApiProvider>()
          .getData(url: "dashboard/getAllPipelines", body: {});
      if (response is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsg));
      } else {
       final model = getAllPipelinesFromJson(jsonEncode(response));
        return Right(model);
      }
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsg));
    }
  }
}

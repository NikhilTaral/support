import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/pipeline_tile_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/pipeline_tile_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/pipeline_tile_repository.dart';

class PipelineTileRepoImpl extends PipelineTileRepository {
  final s = serviceLocator<S>();

  @override
  Future<Either<Failure, dynamic>> getPipelineTileData(
      PipelineTileRequestModel? pipelineTileRequestModel) async {
    try {
      if (pipelineTileRequestModel == null) {
        return Left(ServerFailure(message: 'Request model is null'));
      }
      final response = await serviceLocator<ApiProvider>().getData(
          url: "dashboard/getTotalTicketCounts",
          body: pipelineTileRequestModel.toJson());
      if (response is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      }
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
    }
  }
}

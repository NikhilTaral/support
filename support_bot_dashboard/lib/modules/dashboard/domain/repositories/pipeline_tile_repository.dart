import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/pipeline_tile_request_model.dart';

abstract class PipelineTileRepository {
  Future<Either<Failure, dynamic>> getPipelineTileData(
    PipelineTileRequestModel? pipelineTileRequestModel,
  );
}

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/pipeline_tile_repository.dart';

class PipelineTileUsecase {
  Future<Either<Failure, dynamic>> invoke(pipelineTileRequestModel) async {
    return await serviceLocator<PipelineTileRepository>()
        .getPipelineTileData(pipelineTileRequestModel);
  }
}

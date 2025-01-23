import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/get_all_pipelines_repository.dart';

class GetAllPipelinesUsecase {
  Future<Either<Failure, dynamic>> invoke() async {
    return await serviceLocator<GetAllPipelinesRepository>().getAllPipeline();
  }
}

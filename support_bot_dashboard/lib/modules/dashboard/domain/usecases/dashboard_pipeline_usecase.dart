import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_pipeline_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class DashboardPipelineUsecase implements UseCaseNoInput {
  @override
  Future<Either<Failure, dynamic>> invoke() async {
    return await serviceLocator<DashboardPipelineRepository>().getPipelineData();
  }

}

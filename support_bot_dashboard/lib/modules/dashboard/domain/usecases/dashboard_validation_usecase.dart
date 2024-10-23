import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_validation_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class DashboardValidationUsecase implements UseCaseFiveInput<String , String, String , String, String,dynamic>{
  @override
  Future<Either<Failure, dynamic>> invoke(
       id,  validation,  reason, pipeline, classification) async {
    return await serviceLocator<DashboardValidationRepository>()
        .updateClassificationValidation(id: id, validation: validation, reason: reason, pipeline: pipeline,classification: classification);
  }
}
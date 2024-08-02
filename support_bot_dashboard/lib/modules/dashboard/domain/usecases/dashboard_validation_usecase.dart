import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_table_data_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class DashboardValidationUsecase implements UseCaseThreeInput<String , String, String , dynamic>{
  @override
  Future<Either<Failure, dynamic>> invoke(
       id,  validation,  reason) async {
    return await serviceLocator<DashboardTableDataRepository>()
        .updateClassificationValidation(id: id, validation: validation, reason: reason);
  }
}
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_table_data_Repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

class DashboardValidationUsecase {
  Future<Either<Failure, dynamic>> invoke(String id,String validation, String reason) async {
    return await serviceLocator<DashboardTableDataRepository>().updateClassificationValidation(id, validation, reason);
  }
}


import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_validation_count_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class DashboardGetValidationCountUsecase implements UseCaseThreeInput{
  @override
  Future<Either<Failure, dynamic>> invoke(
       date,month, pipeline) async {
    return await serviceLocator<GetValidationCountRepository>()
        .getValidationCount(date, month,pipeline);
  }
}
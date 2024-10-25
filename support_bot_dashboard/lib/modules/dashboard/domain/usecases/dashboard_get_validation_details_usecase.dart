import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/use_case/use_case.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_validation_details_repository.dart';


class DashboardGetValidationDetailsUsecase implements UseCaseOneInput<String, dynamic> {
  @override
  Future<Either<Failure, dynamic>>  invoke(ticketId) async {
    return await serviceLocator<DashboardGetValidationDetailsRepository>()
        .getValidationDetails(ticketId: ticketId);
  }
}



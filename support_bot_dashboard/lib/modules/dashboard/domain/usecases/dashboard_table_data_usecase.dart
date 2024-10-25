import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_validation_details_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_table_data_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class DashboardTableDatausecase implements UseCaseEightInput {
  @override
  Future<Either<Failure, dynamic>> invoke(date, month, pipeline, ticketId,
      classification, classificationValidation, page, pageSize) async {
    return await serviceLocator<DashboardTableDataRepository>()
        .getDashboardTableData(
            selectedDate: date,
            selectedMonth: month,
            pipeline: pipeline,
            ticketId: ticketId,
            classification: classification,
            classificationValidation: classificationValidation,
            page: page,
            pageSize: pageSize);
  }
}

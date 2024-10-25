import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_export_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class DashboardExportusecase implements UseCaseSixInput {
  @override
  Future<Either<Failure, dynamic>> invoke(date, month, pipeline, ticketId,
      classification, classificationValidation) async {
    return await serviceLocator<DashboardExportRepository>()
        .getExportData(
            selectedDate: date,
            selectedMonth: month,
            pipeline: pipeline,
            ticketId: ticketId,
            classification: classification,
            classificationValidation: classificationValidation,);
  }
}

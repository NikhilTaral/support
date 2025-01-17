import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/use_case/use_case.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_export_repository.dart';

class DashboardExportusecase implements UseCaseSevenInput {
  @override
  Future<Either<Failure, dynamic>> invoke(startDate, endDate, pipeline,
      ticketId, bopsState, classification, classificationValidation) async {
    return await serviceLocator<DashboardExportRepository>().getExportData(
      startDate: startDate,
      endDate: endDate,
      pipeline: pipeline,
      ticketId: ticketId,
      bopsState: bopsState,
      classification: classification,
      classificationValidation: classificationValidation,
    );
  }
}

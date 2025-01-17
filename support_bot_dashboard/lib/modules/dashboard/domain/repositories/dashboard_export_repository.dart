import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

abstract class DashboardExportRepository {
  Future<Either<Failure, dynamic>> getExportData(
      {DateTime? startDate,
      DateTime? endDate,
      String? pipeline,
      String? ticketId,
      String? classification,
      String? classificationValidation,
      String? bopsState});
}

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class DashboardExportRepository {
  Future<Either<Failure, dynamic>> getExportData(
      {DateTime? selectedDate,
      DateTime? selectedMonth,
      String? pipeline,
      String? ticketId,
      String? classification,
      String? classificationValidation});
}

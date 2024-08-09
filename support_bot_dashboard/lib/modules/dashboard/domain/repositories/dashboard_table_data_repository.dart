import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class DashboardTableDataRepository {
  Future<Either<Failure, dynamic>> getDashboardTableData(
      {DateTime? selectedDate, DateTime? selectedMonth});
}

abstract class DashboardFilterClassificationDataRepository {
  Future<Either<Failure, dynamic>> getDashboardClassificationData(
      {DateTime? selectedDate, DateTime? selectedMonth, String? classification,  String? classificationValidation});
}

abstract class DashboardFilterClassificationValidationDataRepository {
  Future<Either<Failure, dynamic>> getDashboardClassificationValidationData(
      {DateTime? selectedDate, DateTime? selectedMonth, String? classification, String? classificationValidation});
}
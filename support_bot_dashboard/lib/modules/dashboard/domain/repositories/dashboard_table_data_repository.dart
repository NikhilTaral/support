import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class DashboardTableDataRepository {
  Future<Either<Failure, dynamic>> getDashboardTableData(
      {DateTime? selectedDate, DateTime? selectedMonth});
}
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class DashboardChartDataRepository {
  Future<Either<Failure, dynamic>> getDashboardChartData(
      {DateTime? selectedDate, DateTime? selectedMonth});
}

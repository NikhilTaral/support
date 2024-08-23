import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class DashboardAiQueryChartDataRepository {

  Future<Either<Failure, dynamic>> getAiQueryChartData(DateTime? selectedDate, DateTime? selectedMonth);

}
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class DashboardAiQueryRepository {
  Future<Either<Failure, dynamic>> getAiQueryTableData(
      {DateTime? selectedDate, DateTime? selectedMonth, String? pipeline});
}

abstract class FilterAiQueryAnswerRepository {
  Future<Either<Failure, dynamic>> getFilterAiQueryData({DateTime? selecedDate, DateTime? selectedMonth, bool? selectedClassification});
}
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class GetValidationCountRepository {

  Future<Either<Failure, dynamic>> getValidationCount(DateTime? selectedDate, DateTime? selectedMonth, String? pipeline);

}
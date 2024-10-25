import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class GetValidationByCountRepository {

  Future<Either<Failure, dynamic>> getValidationByCount(DateTime? selectedDate, DateTime? selectedMonth, String? pipeline);

}
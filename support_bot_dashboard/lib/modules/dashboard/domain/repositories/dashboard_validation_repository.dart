import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class DashboardValidationRepository {
  Future<Either<Failure, dynamic>> updateClassificationValidation(
      {String id, String validation, String reason, String pipeline});
}
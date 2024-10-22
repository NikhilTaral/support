import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';

abstract class DashboardGetValidationDetailsRepository {
  Future<Either<Failure, dynamic>> getValidationDetails(
      {String ticketId});
}


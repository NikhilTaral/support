import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class DashboardPipelineRepository {
  Future<Either<Failure, dynamic>> getPipelineData();
}
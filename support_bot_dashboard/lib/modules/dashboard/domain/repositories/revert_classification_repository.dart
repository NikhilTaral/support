import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class RevertClassificationRepository {
  Future<Either<Failure, dynamic>> revertClassification(
      {String id});
}

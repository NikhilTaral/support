import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class UnRevertClassificationRepository {
  Future<Either<Failure, dynamic>> unRevertClassification(
      {String ticketId, String classification});
}

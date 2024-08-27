import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class UpdateAiAnswerRepository {
  Future<Either<Failure, dynamic>> updateAiAnswer(String? ticketId, String? newAnswer);
}

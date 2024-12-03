import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class SendEmailAiAnswerRepository {
  Future<Either<Failure, dynamic>> sendEmailAiAnswer(String? ticketId, bool? agentAnsvalidation, String? selectedPipeline);
}

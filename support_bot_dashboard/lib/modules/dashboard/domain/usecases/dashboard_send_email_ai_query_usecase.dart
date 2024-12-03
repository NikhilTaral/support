import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_send_email_ai_query_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class SendEmailAiAnswerUsecase implements UseCaseThreeInput<String,String,String, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(String? ticketId, String? newAnswer, String? selectedPipeline) async {
    return await serviceLocator.get<SendEmailAiAnswerRepository>()
        .sendEmailAiAnswer(ticketId, newAnswer,selectedPipeline);
  }
}

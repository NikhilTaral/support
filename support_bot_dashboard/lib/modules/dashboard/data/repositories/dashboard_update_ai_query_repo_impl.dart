import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/config/environment/env_config.dart';
import 'package:support_bot_dashboard/core/prerequisites/api_prerequisites.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_update_ai_query_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

class UpdateAiAnswerRepoImpl extends UpdateAiAnswerRepository {
  @override
  Future<Either<Failure, dynamic>> updateAiAnswer(String? ticketId, String? newAnswer) async {
    final uri = Uri.parse('${EnvConfig.EXP_API_URL}/dashboard/updateAIAnswer');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "${await getToken()}",
    };
    final body = jsonEncode({
      'ticketId': ticketId,
      'newAnswer': newAnswer,
    });
    final response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      return Right(response);
    } else {
      return Left(ServerFailure(message: 'Answer not updated'));
    }
  }
}

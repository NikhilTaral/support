import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/config/environment/env_config.dart';
import 'package:support_bot_dashboard/core/prerequisites/api_prerequisites.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/unrevert_classification_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

class UnRevertClassificationRepoImpl extends UnRevertClassificationRepository {
  @override
  Future<Either<Failure, dynamic>> unRevertClassification({String? ticketId, String? classification}) async {
    final uri = Uri.parse('${EnvConfig.EXP_API_URL}/hubspot/updateTicket');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "${await getToken()}",
    };
    final body = jsonEncode({
      'ticketId': ticketId,
      'classification': classification
    });
    final response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      return Right(response);
    } else {
      return Left(ServerFailure(message: 'Data Unrevert failed'));
    }
  }
}

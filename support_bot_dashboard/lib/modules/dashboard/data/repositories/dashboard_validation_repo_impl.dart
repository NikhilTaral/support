import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:support_bot_dashboard/config/environment/env_config.dart';
import 'package:support_bot_dashboard/core/prerequisites/api_prerequisites.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_validation_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

class DashboardValidationRepoImpl extends DashboardValidationRepository {
  
   @override
  Future<Either<Failure, dynamic>> updateClassificationValidation(
      {String? id, String? validation, String? reason, String? pipeline, String? classification}) async {
    final uri = Uri.parse(
        '${EnvConfig.EXP_API_URL}/dashboard/updateClassificationValidation');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "${await getToken()}",
    };
    final body = jsonEncode({
      'id': id,
      'validation': validation,
      'reason': reason,
      'pipeline': pipeline,
      'validatedClassification': classification
    });
    final response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      return Right(response);
    } else {
      return Left(ServerFailure(message: 'Data updation failed'));
    }
  }

}



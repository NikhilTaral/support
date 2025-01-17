import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/config/environment/env_config.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/prerequisites/api_prerequisites.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_export_repository.dart';
import 'package:http/http.dart' as http;

class DashboardExportRepoImpl extends DashboardExportRepository {
  @override
  Future<Either<Failure, dynamic>> getExportData({
    DateTime? startDate,
    DateTime? endDate,
    String? pipeline,
    String? ticketId,
    String? bopsState,
    String? classification,
    String? classificationValidation,
  }) async {
    final uri = Uri.parse(
        '${EnvConfig.EXP_API_URL}/dashboard/getExportRecordsDynamoDB');
    Map<String, dynamic> body = {};

    if (startDate != null) {
      body['startDate'] = startDate.toIso8601String().substring(0, 10);
    }

    // Return early if endDate is null
    if (endDate == null) {
      return Left(ServerFailure(message: 'End date is required'));
    }

    body['endDate'] = endDate.toIso8601String().substring(0, 10);

    if (pipeline != null) {
      body['pipeline'] = pipeline;
    }
    if (ticketId != null) {
      body['ticketId'] = ticketId;
    }
    if (classification != null && classification.isNotEmpty) {
      body['classification'] = classification;
    }
    if (bopsState != null && bopsState.isNotEmpty) {
      body['BOPS_State'] = bopsState;
    }
    if (classificationValidation != null) {
      body['classificationValidation'] = classificationValidation;
    }

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': await getToken(),
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      return Right(response.bodyBytes);
    } else {
      try {
        final errorBody = json.decode(response.body);
        return Left(ServerFailure(
            message: errorBody['message'] ?? 'Export request failed'));
      } catch (e) {
        return Left(ServerFailure(
            message: 'Export failed with status: ${response.statusCode}'));
      }
    }
  }
}

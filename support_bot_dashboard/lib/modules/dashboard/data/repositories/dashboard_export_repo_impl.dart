import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/config/environment/env_config.dart';
import 'package:support_bot_dashboard/core/prerequisites/api_prerequisites.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_export_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:http/http.dart' as http;

class DashboardExportRepoImpl extends DashboardExportRepository {
  @override
  Future<Either<Failure, dynamic>> getExportData(
      {DateTime? selectedDate,
      DateTime? selectedMonth,
      String? pipeline,
      String? ticketId,
      String? classification,
      String? classificationValidation}) async {
          final uri =
        Uri.parse('${EnvConfig.EXP_API_URL}/dashboard/getExportRecordsDynamoDB');
     Map<String, dynamic> body = {};
      if (selectedDate != null) {
        body['day'] = selectedDate.toIso8601String().substring(0, 10);
      }
      if (selectedMonth != null) {
        body['month'] =
            '${selectedMonth.year}-${selectedMonth.month.toString().padLeft(2, '0')}';
      }
      if (pipeline != null) {
        body['pipeline'] = pipeline;
      }
      if (ticketId != null) {
        body['ticketId'] = ticketId;
      }
      if (classification != null && classification.isNotEmpty) {
        body['classification'] = classification;
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

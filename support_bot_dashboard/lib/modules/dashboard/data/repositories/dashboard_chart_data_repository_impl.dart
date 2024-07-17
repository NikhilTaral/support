import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:support_bot_dashboard/config/environment/env_config.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_chart_data_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

class DashboardChartDataRepoImpl extends DashboardChartDataRepository {
  @override
  Future<Either<Failure, dynamic>> getDashboardChartData(
      {DateTime? selectedDate, DateTime? selectedMonth}) async {
    final uri =
        Uri.parse('${EnvConfig.EXP_API_URL}/dashboard/getCategoryCounts');
    final headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {};

    if (selectedDate != null) {
      body['day'] = selectedDate.toIso8601String().substring(0, 10);
    }

    if (selectedMonth != null) {
      body['month'] =
          '${selectedMonth.year}-${selectedMonth.month.toString().padLeft(2, '0')}';
    }

    final encodedBody = jsonEncode(body);

    final response = await http.post(uri, headers: headers, body: encodedBody);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return Right(DashboardChartResponseModel.fromJson(jsonData));
    } else {
      return Left(
          ServerFailure(message: 'Failed to load dashboard chart data'));
    }
  }
}

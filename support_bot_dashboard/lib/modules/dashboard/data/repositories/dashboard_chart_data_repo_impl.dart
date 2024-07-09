import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:support_bot_dashboard/config/environment/env_config.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_response_mdeil.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_chart_data_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

class DashboardChartDataRepoImpl extends DashboardChartDataRepository {

  @override
  Future<Either<Failure, dynamic>> getDashboardChartData(DateTime selectedDate) async {
    final uri = Uri.parse(EnvConfig.total_tickets);
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'day': selectedDate.toIso8601String().substring(0, 10),
    });

    final response = await http.post(uri, headers: headers, body: body);

    if (response == null) {
      return Left(ServerFailure(message: "Failure"));
    } else if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return Right(DashboardChartResponseModel.fromJson(jsonData));
    } else {
      return Left(ServerFailure(message: 'Failed to load dashboard chart data'));
    }
  }

}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/config/environment/env_config.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_pluto_table_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_table_data_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

class DashboardTableDataRepoImpl extends DashboardTableDataRepository {
  @override
  Future<Either<Failure, dynamic>> getDashboardTableData(
      {DateTime? selectedDate, DateTime? selectedMonth}) async {
    final uri =
        Uri.parse('${EnvConfig.EXP_API_URL}/dashboard/getRecordsDynamoDB');
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
      if (response.body.isNotEmpty) {
        try {
          final Map<String, dynamic> jsonData = jsonDecode(response.body);

          return Right(DashboardPlutotableResponseModel.fromJson(jsonData));
        } catch (e) {
          return Left(
              ServerFailure(message: 'Failed to load dashboard table data'));
        }
      } else {
        return Left(ServerFailure(message: 'Empty response body'));
      }
    } else {
      return Left(
          ServerFailure(message: 'Failed to load dashboard table data'));
    }
  }

  
}

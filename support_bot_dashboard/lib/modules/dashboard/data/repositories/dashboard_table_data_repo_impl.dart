import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/config/environment/env_config.dart';
import 'package:support_bot_dashboard/core/prerequisites/api_prerequisites.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_pluto_table_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_table_data_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

class DashboardTableDataRepoImpl extends DashboardTableDataRepository {
  @override
  Future<Either<Failure, dynamic>> getDashboardTableData(
      {DateTime? selectedDate, DateTime? selectedMonth,  String? pipeline, String? ticketId}) async {
    final uri =
        Uri.parse('${EnvConfig.EXP_API_URL}/dashboard/getRecordsDynamoDB');
    

    Map<String, dynamic> body = {};

    if (selectedDate != null) {
      body['day'] = selectedDate.toIso8601String().substring(0, 10);
    }

    if (selectedMonth != null) {
      body['month'] =
          '${selectedMonth.year}-${selectedMonth.month.toString().padLeft(2, '0')}';
    }

    if(pipeline != null){
      body['pipeline'] = pipeline;
    }

    if(ticketId != null){
      body['ticketId'] = ticketId;
    }

    final encodedBody = jsonEncode(body);

    final response = await http.post(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': await getToken(),
    }, 
    body: encodedBody);

    if (response.statusCode == 200) {
        try {
          return Right(response.body);
        } catch (e) {
          return Left(
              ServerFailure(message: 'Failed to load dashboard table data'));
        }
    } else {
      return Left(
          ServerFailure(message: 'Failed to load dashboard table data'));
    }
  }
}

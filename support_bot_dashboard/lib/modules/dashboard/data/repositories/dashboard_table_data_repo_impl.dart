import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_response_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_table_data_repository.dart';

class DashboardTableDataRepoImpl extends DashboardTableDataRepository {
  @override
  Future<List<DashboardResponseDataModel>> fetchTableData() async {
    final response =
        await rootBundle.loadString('assets/json/dashboard_data.json');

    final List<dynamic> jsonData = json.decode(response);
    final List<DashboardResponseDataModel> data = jsonData
        .map((json) => DashboardResponseDataModel.fromJson(json))
        .toList();
    return data;
  }


}

import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_response_data_model.dart';

abstract class DashboardDataRepository {
  Future<List<DashboardResponseDataModel>> fetchTableData();
  Future<List<ChartData>> piechartData();
}

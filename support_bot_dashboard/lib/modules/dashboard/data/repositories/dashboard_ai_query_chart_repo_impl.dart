import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_ai_query_chart_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

class DashboardAiQueryChartRepoImpl
    extends DashboardAiQueryChartDataRepository {
  @override
  Future<Either<Failure, dynamic>> getAiQueryChartData(
      DateTime? selectedDate, DateTime? selectedMonth, String? pipeline) async {
    final ApiProvider _apiProvider = serviceLocator<ApiProvider>();

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

    dynamic response;
    response = await _apiProvider.getData(
      url: 'dashboard/getAnswerCount',
      body: body,
    );
    if (response == null) {
      return Left(ServerFailure(message: 'No response from server'));
    }
    return Right(response);
  }
}

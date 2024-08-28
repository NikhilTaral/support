import 'package:either_dart/src/either.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_ai_query_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

class DashboardAiQueryFilterClassificationRepoImpl extends FilterAiQueryAnswerRepository{
  @override
  Future<Either<Failure, dynamic>> getFilterAiQueryData({DateTime? selecedDate, DateTime? selectedMonth, bool? selectedClassification}) async{
  final ApiProvider _apiProvider = serviceLocator<ApiProvider>();

    Map<String, dynamic> body = {};

    if (selecedDate != null) {
      body['day'] = selecedDate.toIso8601String().substring(0, 10);
    }

    if (selectedMonth != null) {
      body['month'] =
          '${selectedMonth.year}-${selectedMonth.month.toString().padLeft(2, '0')}';
    }

     if (selectedClassification != null) {
      body['answeredStatus'] = selectedClassification;
    }

    dynamic response;
    response = await _apiProvider.getData(
      url: 'dashboard/getAIResponse',
      body: body,
    );
    if (response == null) {
      return Left(ServerFailure(message: 'No response from server'));
    }
      try {
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to parse response: $e'));
    }
  }

}
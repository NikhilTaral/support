import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_ai_query_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class DashboardAiQueryUsecase implements UseCaseThreeInput {
  @override
  Future<Either<Failure, dynamic>> invoke(date, month, pipeline) async {
    return await serviceLocator<DashboardAiQueryRepository>()
        .getAiQueryTableData(
            selectedDate: date, selectedMonth: month, pipeline: pipeline);
  }
}

class DashboardFilterAiQueryUsecase implements UseCaseFourInput{
   @override
  Future<Either<Failure, dynamic>> invoke(
      date, month, selectedClassification, pipeline) async {
    return await serviceLocator<FilterAiQueryAnswerRepository>().getFilterAiQueryData(selecedDate: date,selectedMonth: month,selectedClassification: selectedClassification, pipeline: pipeline);
  }
}
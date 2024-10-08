import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_ai_query_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class DashboardAiQueryUsecase implements UseCaseSixInput {
  @override
  Future<Either<Failure, dynamic>> invoke(
      date, month, pipeline, page, pageSize,selectedClassification) async {
    return await serviceLocator<DashboardAiQueryRepository>()
        .getAiQueryTableData(
            selectedDate: date,
            selectedMonth: month,
            pipeline: pipeline,
            page: page,
            pageSize: pageSize,
            selectedClassification: selectedClassification
            );
  }
}


import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_table_data_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class DashboardFilterClassificationDatausecase implements UseCaseFourInput{
  @override
  Future<Either<Failure, dynamic>> invoke(
      date, month, classification, classificationValidation) async {
    return await serviceLocator<DashboardFilterClassificationDataRepository>()
        .getDashboardClassificationData(selectedDate: date, selectedMonth: month, classification: classification, classificationValidation: classificationValidation);
  }
}

class DashboardFilterClassificationValidationDatausecase implements UseCaseFourInput{
  @override
  Future<Either<Failure, dynamic>> invoke(
      date, month, classification, classificationValidation) async {
    return await serviceLocator<DashboardFilterClassificationValidationDataRepository>()
        .getDashboardClassificationValidationData(selectedDate: date, selectedMonth: month, classification: classification, );
  }
}
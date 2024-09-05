// import 'package:either_dart/either.dart';
// import 'package:support_bot_dashboard/injectable_init.dart';
// import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_table_data_repository.dart';
// import 'package:support_bot_dashboard/utils/service/failure.dart';
// import 'package:support_bot_dashboard/utils/service/usecase.dart';

// class DashboardFilterClassificationDatausecase implements UseCaseFiveInput{
//   @override
//   Future<Either<Failure, dynamic>> invoke(
//       date, month, classification, classificationValidation,pipeline) async {
//     return await serviceLocator<DashboardFilterClassificationDataRepository>()
//         .getDashboardClassificationData(selectedDate: date, selectedMonth: month, classification: classification, classificationValidation: classificationValidation,pipeline: pipeline);
//   }
// }

// class DashboardFilterClassificationValidationDatausecase implements UseCaseFiveInput{
//   @override
//   Future<Either<Failure, dynamic>> invoke(
//       date, month, classification, classificationValidation,pipeline) async {
//     return await serviceLocator<DashboardFilterClassificationValidationDataRepository>()
//         .getDashboardClassificationValidationData(selectedDate: date, selectedMonth: month, classification: classification, pipeline: pipeline);
//   }
// }
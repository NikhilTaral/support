
import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_validation_details_repository.dart';

class GetValidationDetailsRepositoryImpl extends DashboardGetValidationDetailsRepository{
  @override
  Future<Either<Failure, dynamic>> getValidationDetails({String? ticketId}) async{
     final ApiProvider _apiProvider = serviceLocator<ApiProvider>();

    dynamic response;
    response = await _apiProvider.getData(
      url: 'dashboard/getValidationDetails',
      body: {
        'id': ticketId,
      },
    );
    if (response == null) {
      return Left(ServerFailure(message: 'No response from server'));
    }
    return Right(response);
  }

}
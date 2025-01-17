import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/use_case/use_case.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/get_validation_details_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_action_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/update_classification_validation_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/repositories/common_ticket_classification_repository.dart';

class TicketClassificationUsecses {
  Future<Either<Failure, dynamic>> invoke(
      ticketClassificationRequestModel) async {
    return await serviceLocator<TicketClassifiacationRepository>()
        .getTicketClassification(ticketClassificationRequestModel);
  }
}

class BopsUsecases {
  Future<Either<Failure, dynamic>> invoke() async {
    return await serviceLocator<BopsRepository>().getBopsData();
  }
}

class ActionUsecase {
  Future<Either<Failure, dynamic>> invoke(
      TicketClassificationActionRequestModel?
          ticketClassificationActionRequestModel) async {
    return await serviceLocator<ActionRepository>()
        .getActionRequest(ticketClassificationActionRequestModel);
  }
}

class UpdateClassificationValidationUsecase {
  Future<Either<Failure, dynamic>> invoke(
      UpdateClassificationValidationRequestModel?
          updateClassificationValidationRequestModel) async {
    return await serviceLocator<UpdateClassificationValidationRepository>()
        .getUpdateClassificationValidat(
            updateClassificationValidationRequestModel);
  }
}

class GetValidationDetailsUsecase {
  Future<Either<Failure, dynamic>> invoke(
      GetValidationDetailsRequestModel?
          getValidationDetailsRequestModel) async {
    return await serviceLocator<GetValidationDetailsRepository>()
        .getgetValidationDetails(getValidationDetailsRequestModel);
  }
}
class RevertClassificationUsecase implements UseCaseOneInput<String, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(ticketId) async {
    return await serviceLocator<RevertClassificationRepository>()
        .revertClassification(ticketId: ticketId);
  }
}
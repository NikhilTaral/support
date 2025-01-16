import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/get_validation_details_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_action_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/update_classification_validation_request_model.dart';

abstract class TicketClassifiacationRepository {
  Future<Either<Failure, dynamic>> getTicketClassification(
      TicketClassificationRequestModel? ticketClassificationRequestModel);
}

abstract class BopsRepository {
  Future<Either<Failure, dynamic>> getBopsData();
}

abstract class ActionRepository {
  Future<Either<Failure, dynamic>> getActionRequest(
      TicketClassificationActionRequestModel?
          ticketClassificationActionRequestModel);
}
abstract class UpdateClassificationValidationRepository {
  Future<Either<Failure, dynamic>> getUpdateClassificationValidat(
      UpdateClassificationValidationRequestModel?
          updateClassificationValidationRequestModel);
}

abstract class GetValidationDetailsRepository {
  Future<Either<Failure, dynamic>> getgetValidationDetails(
      GetValidationDetailsRequestModel?
          getValidationDetailsRequestModel);
}
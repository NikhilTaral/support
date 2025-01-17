import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/revert_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/bops_state_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/get_validation_details_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_action_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_action_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/update_classification_validation_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/update_classification_validation_responce_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/repositories/common_ticket_classification_repository.dart';

final s = serviceLocator<S>();

class TicketClassificationRepoImpl extends TicketClassifiacationRepository {
  @override
  Future<Either<Failure, dynamic>> getTicketClassification(
      TicketClassificationRequestModel?
          ticketClassificationRequestModel) async {
    if (ticketClassificationRequestModel != null) {
    } else {}

    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
          url: 'dashboard/getRecordsDynamoDB',
          body: ticketClassificationRequestModel?.toJson());
      if (response is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsg));
      }

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsg));
    }
  }
}

class BopsRepoImpl extends BopsRepository {
  @override
  Future<Either<Failure, dynamic>> getBopsData() async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>()
          .getData(url: 'dashboard/getAllBOPSStates', body: {});
      final model = bOpsResponseModelFromJson(jsonEncode(response));
      if (model is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsg));
      }

      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsg));
    }
  }
}

class ActionRepoImpl extends ActionRepository {
  @override
  Future<Either<Failure, dynamic>> getActionRequest(
      TicketClassificationActionRequestModel?
          ticketClassificationActionRequestModel) async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
          url: 'hubspot/updateTicket',
          body: ticketClassificationActionRequestModel?.toJson());
      final model = revertResponseModelFromJson(jsonEncode(response));

      if (model is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsg));
      }
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsg));
    }
  }
}

class UpdateClassificationValidationImpl
    extends UpdateClassificationValidationRepository {
  @override
  Future<Either<Failure, dynamic>> getUpdateClassificationValidat(
      UpdateClassificationValidationRequestModel?
          updateClassificationValidationRequestModel) async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
          url: 'dashboard/updateClassificationValidation',
          body: updateClassificationValidationRequestModel?.toJson());

      final model = updateClassificationValidationResponseModelFromJson(
          jsonEncode(response));
      if (model is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsg));
      }
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsg));
    }
  }
}

class GetValidationDetailsImpl extends GetValidationDetailsRepository {
  @override
  Future<Either<Failure, dynamic>> getgetValidationDetails(
      GetValidationDetailsRequestModel?
          getValidationDetailsRequestModel) async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
          url: 'dashboard/getValidationDetails',
          body: getValidationDetailsRequestModel?.toJson());

      final model = updateClassificationValidationResponseModelFromJson(
          jsonEncode(response));
      if (model is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsg));
      }
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsg));
    }
  }
}

class RevertClassificationImpl extends RevertClassificationRepository {
  @override
  Future<Either<Failure, dynamic>> revertClassification(
      {String? ticketId}) async {
    try {
      final dynamic response = await serviceLocator<ApiProvider>().getData(
          url: 'hubspot/revertTicketUpdate', body: {'ticketId': ticketId});

      if (response is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsg));
      }

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsg));
    }
  }
}

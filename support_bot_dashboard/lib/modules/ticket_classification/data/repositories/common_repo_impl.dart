import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/dashboard_export_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/get_all_validation_users_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/get_all_validation_users_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/revert_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/bops_state_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/get_validation_details_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_action_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/update_classification_validation_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/update_classification_validation_response_model.dart';
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
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      }

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
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
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      }

      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
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
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      }
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
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
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      }
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
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
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      }
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
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

      final model = revertResponseModelFromJson(jsonEncode(response));
      if (model is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      }
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
    }
  }
}

class DashboardExportImpl extends DashboardExportRepository {
  @override
  Future<Either<Failure, File>> getExportData(
      DashboardExportRequestModel? dashboardExportRequestModel) async {
    try {
      final Uint8List? response = await serviceLocator<ApiProvider>()
          .downloadCsv(
              url: 'dashboard/getExportRecordsDynamoDB',
              body: dashboardExportRequestModel?.toJson());

      if (response == null) {
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      } else {
        return Right(response.length == 0
            ? File('')
            : File.fromRawPath(Uint8List.fromList(response)));
      }
    } catch (e) {
      return Left(ServerFailure(message: s.aPIErrorMsgText));
    }
  }
}

class GetAllValidationUserImpl extends GetAllValidationUserRepository {
  @override
  Future<Either<Failure, GetAllValidationUsersResponseModel>>
      getAllValidationUser(
          GetAllValidationUsersRequestModel?
              getAllValidationUsersRequestModel) async {
    try {
final response = await serviceLocator<ApiProvider>().getData(
          url: 'dashboard/getAllValidationUsers',
          body: getAllValidationUsersRequestModel?.toJson());

      final model =
          getAllValidationUsersResponseModelFromJson(jsonEncode(response));

      if (model is Left) {
        return Left(ServerFailure(message: s.aPIErrorMsgText));
      }

      return Right(model);
    } catch (e) {
       return Left(ServerFailure(message: s.aPIErrorMsgText));
    }
  }
}

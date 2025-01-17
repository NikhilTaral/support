// class V3LoginSendJoinEmail implements UseCaseTwoInput {
//   @override
//   Future<Either<Failure, dynamic>> invoke(email, name) async {
//     return await serviceLocator
//         .get<V3LoginRepositories>()
//         .sendJoinEmail(email, name);
//   }
// }

import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/core/error/failure.dart';
import 'package:support_bot_dashboard/core/use_case/use_case.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/login_v3/domain/repositories/v3_login_repositories.dart';

class V3LoginSaveOnboardingEmailAndName implements UseCaseTwoInput {
  @override
  Future<Either<Failure, dynamic>> invoke(email, name) async {
    return await serviceLocator
        .get<V3LoginRepositories>()
        .saveOnboardingEmailAndName(email, name);
  }
}

// class V3LoginSaveJoiningBotEmail implements UseCaseOneInput {
//   @override
//   Future<Either<Failure, dynamic>> invoke(email) async {
//     return await serviceLocator
//         .get<V3LoginRepositories>()
//         .saveJoinBotEmail(email);
//   }
// }

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class UseCaseNoInput<Output> {
  Future<Either<Failure, Output>> invoke();
}

abstract class UseCaseOneInput<Input, Output> {
  Future<Either<Failure, Output>> invoke(Input input);
}

abstract class UseCaseTwoInput<Input, Input1, Output> {
  Future<Either<Failure, Output>> invoke(Input input, Input1 input1);
}

abstract class UseCaseThreeInput<Input, Input1, Input2, Output> {
  Future<Either<Failure, Output>> invoke(
      Input input, Input1 input1, Input2 input2);
}

abstract class UseCaseFourInput<Input, Input1, Input2, Input3, Output> {
  Future<Either<Failure, Output>> invoke(
      Input params, Input1 params1, Input2 params2, Input3 params3);
}

abstract class UseCaseFiveInput<Input, Input1, Input2, Input3, Input4, Output> {
  Future<Either<Failure, Output>> invoke(
      Input params, Input1 params1, Input2 params2, Input3 params3, Input4 params4);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
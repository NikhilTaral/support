part of 'bops_states_bloc.dart';

abstract class BopsStatesState {}


class BopsStatesIntialState extends BopsStatesState {}

class BopsStatesLoadingState extends BopsStatesState {}

class BopsStatesSuccessState extends BopsStatesState {
  final BOpsResponseAttributeModel? bOpsResponseAttributeModel;
  BopsStatesSuccessState({this.bOpsResponseAttributeModel});
}

class BopsStatesFailureState extends BopsStatesState {}
class BopsStatesEmptyState extends BopsStatesState {}

part of 'bops_states_bloc.dart';

abstract class BopsStatesState {}


class BopsStatesIntialState extends BopsStatesState {}

class BopsStatesLoadingState extends BopsStatesState {}

class BopsStatesSucssesState extends BopsStatesState {
  final BOpsResponseEntitieModel? model;
  BopsStatesSucssesState({this.model});
}

class BopsStatesFailureState extends BopsStatesState {}

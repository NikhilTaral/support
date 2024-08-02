part of 'v3_login_bloc.dart';

abstract class V3LoginState {}

class V3LoginInitialState extends V3LoginState {}

class V3LoginSuccessState extends V3LoginState {}

class V3LoginFailureState extends V3LoginState {}

class V3LoginEmptyState extends V3LoginState {}

class V3LoginLoadingState extends V3LoginState {}

class V3LoginActionState extends V3LoginState {}

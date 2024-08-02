part of 'v3_login_bloc.dart';

abstract class V3LoginEvent {}

class V3LoginInitialEvent extends V3LoginEvent {}

class PerformLogInEvent extends V3LoginEvent {}

class CheckLogInEvent extends V3LoginEvent {}

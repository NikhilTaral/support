part of 'get_ai_response_stat_bloc.dart';

abstract class GetAiResponseStatState {}

class GetAiResponseStatInitialState extends GetAiResponseStatState {}

class GetAiResponseStatLoadingState extends GetAiResponseStatState {}

class GetAiResponseStatSuccessState extends GetAiResponseStatState {
  final GetAiResponseStatAttributeModel? getAiResponseStatAttributeModel;
  GetAiResponseStatSuccessState({this.getAiResponseStatAttributeModel});
}

class GetAiResponseStatFailureState extends GetAiResponseStatState {}

class GetAiResponseStatEmptyState extends GetAiResponseStatState {}

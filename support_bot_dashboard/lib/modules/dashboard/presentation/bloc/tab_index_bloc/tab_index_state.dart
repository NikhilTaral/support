part of 'tab_index_bloc.dart';

abstract class TabIndexState {}

class TabIndexInitialState extends TabIndexState {}

class TabIndexSucssesState extends TabIndexState {
  final int? index;

  TabIndexSucssesState({
    this.index,
  });
}

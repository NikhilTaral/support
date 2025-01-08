part of 'index_bloc.dart';

abstract class IndexState {}

class IndexInitialState extends IndexState {}

class IndexLodingState extends IndexState {}

class IndexSucssesState extends IndexState {
  final int? index;

  IndexSucssesState({
    this.index,
  });
}

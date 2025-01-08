part of 'index_bloc.dart';

abstract class IndexEvent {}

class CurrentIndexEvent extends IndexEvent {
  final int index;
  CurrentIndexEvent({required this.index});
}

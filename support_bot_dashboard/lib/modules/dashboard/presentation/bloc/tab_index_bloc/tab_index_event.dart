part of 'tab_index_bloc.dart';

abstract class IndexEvent {}

class TabIndexChangedEvent extends IndexEvent {
  final int currentIndex;
  TabIndexChangedEvent({required this.currentIndex});
}

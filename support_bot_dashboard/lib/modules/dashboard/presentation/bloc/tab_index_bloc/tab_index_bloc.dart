import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_index_state.dart';
part 'tab_index_event.dart';

class TabIndexBloc extends Bloc<IndexEvent, TabIndexState> {
  TabIndexBloc() : super(TabIndexInitialState()) {
    on<TabIndexChangedEvent>(_onTabIndexChangedEvent);
  }
  int currentIndex = 0;
  FutureOr<void> _onTabIndexChangedEvent(
      TabIndexChangedEvent event, Emitter<TabIndexState> emit) {
    currentIndex = event.currentIndex;

    emit(TabIndexSucssesState(index: currentIndex));
  }
}

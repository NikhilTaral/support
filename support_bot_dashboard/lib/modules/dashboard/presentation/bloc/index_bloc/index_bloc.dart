
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'index_state.dart';
part 'index_event.dart';

class IndexBloc extends Bloc<IndexEvent, IndexState> {
  IndexBloc() : super(IndexInitialState()) {
    on<CurrentIndexEvent>(_onIndexEvent);
  }
  int currentIndex = 0;
  FutureOr<void> _onIndexEvent(
      CurrentIndexEvent event, Emitter<IndexState> emit) {
    currentIndex = event.index;

    emit(IndexSucssesState(index: currentIndex));
   }
}

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'custombutton_event.dart';
part 'custombutton_state.dart';

class CustombuttonBloc extends Bloc<CustombuttonEvent, CustombuttonState> {
  CustombuttonBloc() : super(CustomButtonInitial('Ticket Classification')) {
    on<SelectButtonEvent>(_onSelectButtonEvent);
  }

  Future<void> _onSelectButtonEvent(
      SelectButtonEvent event, Emitter<CustombuttonState> emit) async {
    emit(ButtonSelectedState(event.buttonText));
   
  }
}

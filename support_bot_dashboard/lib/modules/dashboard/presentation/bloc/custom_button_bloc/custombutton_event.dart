part of 'custombutton_bloc.dart';

abstract class CustombuttonEvent{}

class SelectButtonEvent extends CustombuttonEvent{
   final String buttonText;

   SelectButtonEvent(this.buttonText);
}
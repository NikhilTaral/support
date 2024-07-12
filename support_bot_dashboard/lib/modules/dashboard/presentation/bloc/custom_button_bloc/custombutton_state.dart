part of 'custombutton_bloc.dart';


abstract class CustombuttonState{}

class CustomButtonInitial extends CustombuttonState{
  final String selectedButtonText;

 CustomButtonInitial(this.selectedButtonText);
}

class ButtonSelectedState extends CustombuttonState{
   final String selectedButtonText;

  ButtonSelectedState(this.selectedButtonText);
}
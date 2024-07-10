import 'package:flutter/material.dart';

class CommonService extends ChangeNotifier{
   DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  setSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }
}
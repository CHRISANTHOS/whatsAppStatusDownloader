import 'package:flutter/material.dart';

class BottomNavModel extends ChangeNotifier{

  int _currentIndex = 0;


  void changeIndex(int value){
    _currentIndex = value;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;

}
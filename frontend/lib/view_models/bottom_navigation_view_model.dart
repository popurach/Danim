import 'package:flutter/material.dart';

class BottomNavigationViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  BottomNavigationViewModel(this._currentIndex);

  int get currentIndex => _currentIndex;
}

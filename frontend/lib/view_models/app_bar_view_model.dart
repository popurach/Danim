import 'package:flutter/material.dart';

class AppBarViewModel with ChangeNotifier {
  bool _isLogin = true;

  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }
}

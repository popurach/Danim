import 'package:flutter/material.dart';

class AppBarViewModel with ChangeNotifier {
  dynamic _userInfo;

  dynamic get userInfo => _userInfo;

  bool get isLogin {
    return _userInfo != null;
  }

  set userInfo(dynamic value) {
    _userInfo = value;
    notifyListeners();
  }
}

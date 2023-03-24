import 'package:flutter/material.dart';

class CustomAppBarViewModel with ChangeNotifier {
  String _profileImageUrl;
  CustomAppBarViewModel(this._profileImageUrl);

  String get profileImageUrl => _profileImageUrl;

  bool get isLogin {
    return _profileImageUrl != null;
  }

  set profileImageUrl(String value) {
    _profileImageUrl = value;
    notifyListeners();
  }
}

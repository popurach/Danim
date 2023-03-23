import 'package:flutter/material.dart';

class AppBarViewModel with ChangeNotifier {
  String _profileImageUrl = 'https://picsum.photos/id/10/500/500.jpg';

  String get profileImageUrl => _profileImageUrl;

  bool get isLogin {
    return _profileImageUrl != null;
  }

  set profileImageUrl(String value) {
    _profileImageUrl = value;
    notifyListeners();
  }
}

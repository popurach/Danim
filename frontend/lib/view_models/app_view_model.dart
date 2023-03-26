import 'package:flutter/cupertino.dart';

class AppViewModel with ChangeNotifier {
  int currentIndex;
  final String profileImageUrl;

  AppViewModel({this.currentIndex = 0, this.profileImageUrl = ''});

  bool get isLogin {
    return profileImageUrl != null;
  }
}

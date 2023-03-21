import 'package:danim/view_models/app_bar_view_model.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_view_model.dart';

class AppbarBottomNavigationViewModel extends ChangeNotifier {
  final appbarViewModel = AppBarViewModel();
  final bottomNavigationViewModel = BottomNavigationBarViewModel();
}

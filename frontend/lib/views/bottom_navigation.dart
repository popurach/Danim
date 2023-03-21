import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/bottom_navigation_view_model.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarViewModel>(
        builder: (context, viewModel, child) {
      return AnimatedBottomNavigationBar(
        icons: const [Icons.home, Icons.account_circle],
        iconSize: 40,
        activeIndex: viewModel.currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => viewModel.currentIndex = index,
        activeColor: Colors.lightBlue,
      );
    });
  }
}

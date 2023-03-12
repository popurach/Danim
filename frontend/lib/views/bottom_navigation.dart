import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/bottom_navigation_view_model.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarViewModel>(
        create: (_) => BottomNavigationBarViewModel(),
        child: Consumer<BottomNavigationBarViewModel>(
          builder: (context, model, child) => AnimatedBottomNavigationBar(
            icons: const [Icons.home, Icons.account_circle],
            iconSize: 40,
            activeIndex: model.currentIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            onTap: (index) => model.updateIndex(index),
          ),
        ));
  }
}

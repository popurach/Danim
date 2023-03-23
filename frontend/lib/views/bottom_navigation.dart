import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:danim/views/timeline_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/bottom_navigation_view_model.dart';
import '../view_models/modify_profile_view_model.dart';
import 'camera_floating_action_button.dart';
import 'modify_profile.dart';

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
        onTap: (index) {
          viewModel.currentIndex = index;
          if (index == 0) {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => Scaffold(
                          body: const TimeLineList(),
                          floatingActionButton: CameraFloatingActionButton(),
                          floatingActionButtonLocation:
                              FloatingActionButtonLocation.centerDocked,
                          bottomNavigationBar: ChangeNotifierProvider(
                            create: (_) =>
                                BottomNavigationBarViewModel(currentIndex: 0),
                            child: CustomBottomNavigationBar(),
                          ),
                        )));
          } else {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => Scaffold(
                          body: ChangeNotifierProvider(
                              create: (_) => ModifyProfileViewModel(),
                              child: ModifyProfile()),
                          floatingActionButton: CameraFloatingActionButton(),
                          floatingActionButtonLocation:
                              FloatingActionButtonLocation.centerDocked,
                          bottomNavigationBar: ChangeNotifierProvider(
                            create: (_) =>
                                BottomNavigationBarViewModel(currentIndex: 1),
                            child: CustomBottomNavigationBar(),
                          ),
                        )));
          }
        },
        activeColor: Colors.lightBlue,
      );
    });
  }
}

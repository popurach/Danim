import 'package:danim/view_models/bottom_navigation_view_model.dart';
import 'package:danim/view_models/modify_profile_view_model.dart';
import 'package:danim/views/bottom_navigation.dart';
import 'package:danim/views/timeline_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/home_feed_view_model.dart';
import 'camera_floating_action_button.dart';
import 'modify_profile.dart';

class HomeFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeFeedViewModel(),
      child: Consumer<HomeFeedViewModel>(
        builder: (context, viewModel, child) {
          return Navigator(
            key: viewModel.navigatorKey,
            initialRoute: viewModel.timelineListPage,
            onGenerateRoute: (settings) {
              late Widget page;
              if (settings.name == viewModel.modifyProfilePage) {
                page = Scaffold(
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
                );
              } else {
                page = Scaffold(
                  body: const TimeLineList(),
                  floatingActionButton: CameraFloatingActionButton(),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  bottomNavigationBar: ChangeNotifierProvider(
                    create: (_) =>
                        BottomNavigationBarViewModel(currentIndex: 0),
                    child: CustomBottomNavigationBar(),
                  ),
                );
              }
              return MaterialPageRoute(
                  builder: (_) {
                    return page;
                  },
                  settings: settings);
            },
          );
        },
      ),
    );
  }
}

import 'package:danim/view_models/bottom_navigation_view_model.dart';
import 'package:danim/views/bottom_navigation.dart';
import 'package:danim/views/timeline_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/main_frame_view_model.dart';
import 'camera_floating_action_button.dart';

class MainFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeFeedViewModel(),
      child: Consumer<HomeFeedViewModel>(
        builder: (context, viewModel, child) {
          return Navigator(
            key: viewModel.navigatorKey,
            initialRoute: viewModel.initPage,
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                  builder: (_) {
                    return Scaffold(
                      body: const TimeLineList(),
                      floatingActionButton: CameraFloatingActionButton(),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      bottomNavigationBar: ChangeNotifierProvider(
                        create: (_) => BottomNavigationViewModel(0),
                        child: CustomBottomNavigationBar(),
                      ),
                    );
                  },
                  settings: settings);
            },
          );
        },
      ),
    );
  }
}

import 'package:danim/views/timeline_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/main_frame_view_model.dart';

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
                  return TimelineList();
                },
                settings: settings,
              );
            },
          );
        },
      ),
    );
  }
}

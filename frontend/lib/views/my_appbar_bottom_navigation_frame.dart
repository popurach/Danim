import 'package:danim/view_models/appbar_bottom_navigation_view_model.dart';
import 'package:danim/views/app_bar.dart';
import 'package:danim/views/bottom_navigation.dart';
import 'package:danim/views/camera_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppbarBottomNavigationFrame extends StatelessWidget {
  final Widget body;

  MyAppbarBottomNavigationFrame({required this.body});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppbarBottomNavigationViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
            appBar: MyCustomAppBar(
              viewModel: viewModel.appbarViewModel,
            ),
            body: body,
            floatingActionButton: const CameraFloatingActionButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: ChangeNotifierProvider(
              create: (_) => viewModel.bottomNavigationViewModel,
              child: CustomBottomNavigationBar(),
            ));
      },
    );
  }
}

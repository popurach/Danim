import 'package:danim/views/app_bar.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation.dart';
import 'camera_floating_action_button.dart';

class TimelineDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(key: Key("value")),
      body: Container(),
      floatingActionButton: CameraFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

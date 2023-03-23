import 'package:danim/view_models/modify_profile_view_model.dart';
import 'package:danim/view_models/timeline_list_view_model.dart';
import 'package:danim/views/modify_profile.dart';
import 'package:danim/views/timeline_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarViewModel extends ChangeNotifier {
  int currentIndex = 0;

  BottomNavigationBarViewModel({required this.currentIndex});

  final List<Widget> pages = [
    ChangeNotifierProvider(
        create: (_) => TimelineListViewModel(), child: const TimeLineList()),
    ChangeNotifierProvider(
      create: (_) => ModifyProfileViewModel(),
      child: ModifyProfile(),
    )
  ];
}

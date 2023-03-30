import 'package:flutter/material.dart';

import 'package:danim/view_models/search_bar_view_model.dart';
import 'package:danim/models/Timeline.dart';
import 'package:danim/models/Post.dart';

class MyTimeLineListViewModel extends ChangeNotifier {
  late SearchBarViewModel searchBarViewModel;
  List<Timeline> _mytimelineList = [];

  Future<void> _initialize() async {
    // final data = await UserRepository().getMainTimeline();
    // _timelineList = data;
    // for (var timeline in _timelineList) {
    //   await _generatePalette(timeline);
    // }
    notifyListeners();
  }

  MyTimeLineListViewModel() {
    _initialize();
  }

  List<Timeline> get mytimelineList => _mytimelineList;

  @override
  void dispose() {
    _mytimelineList = [];
    super.dispose();
  }
}

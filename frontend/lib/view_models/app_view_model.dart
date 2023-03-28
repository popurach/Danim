import 'package:danim/view_models/modify_profile_view_model.dart';
import 'package:danim/view_models/timeline_detail_view_model.dart';
import 'package:danim/views/timeline_detail_page.dart';
import 'package:danim/views/timeline_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../views/modify_profile.dart';

class AppViewModel with ChangeNotifier {
  int currentIndex;
  final pageController = PageController(initialPage: 0);
  final GlobalKey<NavigatorState> homeFeedNavigatorKey = GlobalKey();
  final GlobalKey<NavigatorState> myFeedNavigatorKey = GlobalKey();

  AppViewModel({this.currentIndex = 0});

  void changePage(index) {
    pageController.jumpToPage(index);
    currentIndex = index;
    notifyListeners();
  }

  onHomeFeedRoute(settings) {
    Widget page;
    if (settings.name!.startsWith('/timeline/detail')) {
      final timelineId = int.parse(settings.name.split('/')[3]);
      page = ChangeNotifierProvider(
        create: (_) => TimelineDetailViewModel(timelineId),
        child: TimelineDetailPage(),
      );
    } else {
      page = TimelineListPage();
    }
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
    );
  }

  onMyFeedRoute(settings) {
    Widget page;
    if (settings.name!.startsWith('/timeline/detail')) {
      final timelineId = int.parse(settings.name.split('/')[3]);
      page = ChangeNotifierProvider(
        create: (_) => TimelineDetailViewModel(timelineId),
        child: TimelineDetailPage(),
      );
    } else {
      page = ChangeNotifierProvider(
        create: (_) => ModifyProfileViewModel(),
        child: ModifyProfile(),
      );
    }
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
    );
  }
}

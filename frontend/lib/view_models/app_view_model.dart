import 'package:danim/view_models/modify_profile_view_model.dart';
import 'package:danim/view_models/timeline_detail_view_model.dart';
import 'package:danim/views/timeline_detail.dart';
import 'package:danim/views/timeline_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../views/modify_profile.dart';

class AppViewModel with ChangeNotifier {
  int currentIndex;
  final String profileImageUrl;
  final pageController = PageController(initialPage: 0);
  final GlobalKey<NavigatorState> homeFeedNavigatorKey = GlobalKey();
  final GlobalKey<NavigatorState> myFeedNavigatorKey = GlobalKey();

  bool get isLogin {
    return profileImageUrl != null;
  }

  AppViewModel({this.currentIndex = 0, this.profileImageUrl = ''});

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
        child: TimelineDetail(),
      );
    } else {
      page = TimelineList();
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
        child: TimelineDetail(),
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

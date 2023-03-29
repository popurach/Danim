import 'package:danim/view_models/timeline_detail_view_model.dart';
import 'package:danim/views/timeline_detail_page.dart';
import 'package:danim/views/timeline_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  onHomeFeedRoute(context, settings) {
    if (settings.name!.startsWith('/timeline/detail')) {
      final timelineId = int.parse(settings.name.split('/')[3]);
      return PageRouteBuilder(
        pageBuilder: (context, __, ___) {
          return ChangeNotifierProvider<TimelineDetailViewModel>(
            create: (_) => TimelineDetailViewModel(context, timelineId),
            child: TimelineDetailPage(),
          );
        },
        transitionDuration: Duration.zero,
      );
    } else {
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => TimelineListPage(),
        transitionDuration: Duration.zero,
      );
    }
  }

  onMyFeedRoute(settings) {
    //TODO 내피드 페이지 이동
  }
}

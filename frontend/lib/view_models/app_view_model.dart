import 'dart:async';

import 'package:danim/services/timeline_repository.dart';
import 'package:danim/view_models/search_bar_view_model.dart';
import 'package:danim/view_models/timeline_detail_view_model.dart';
import 'package:danim/view_models/my_feed_view_model.dart';
import 'package:danim/views/home_feed_page.dart';
import 'package:danim/views/timeline_detail_page.dart';
import 'package:danim/views/my_feed_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../models/UserInfo.dart';
import '../utils/stack.dart';
import '../views/login_page.dart';
import '../views/modify_profile.dart';

class AppViewModel with ChangeNotifier {
  int currentIndex;
  final pageController = PageController(initialPage: 0);
  final GlobalKey<NavigatorState> homeFeedNavigatorKey = GlobalKey();
  final GlobalKey<NavigatorState> myFeedNavigatorKey = GlobalKey();
  UserInfo _userInfo;
  String _title = '';
  final MyStack<String> _formerTitle = MyStack<String>();

  AppViewModel(this._userInfo, this._title, {this.currentIndex = 0});

  String get title => _title;

  UserInfo get userInfo => _userInfo;

  final logger = Logger();

  void changePage(index) {
    pageController.jumpToPage(index);
    if (currentIndex == index) {
      if (index == 0) {
        Navigator.popAndPushNamed(homeFeedNavigatorKey.currentContext!, '/');
      } else {
        Navigator.popAndPushNamed(myFeedNavigatorKey.currentContext!, '/');
      }
    }
    currentIndex = index;
    _formerTitle.clear();
    changeTitle(index == 0 ? '홈' : _userInfo.nickname);
    notifyListeners();
  }

  updateUserInfo(UserInfo userInfo) {
    _userInfo = userInfo;
    notifyListeners();
  }

  goModifyProfilePage() {
    changePage(1);
    changeTitle('프로필 변경');
    Timer(
      const Duration(milliseconds: 100),
      () {
        Navigator.pushNamed(
            myFeedNavigatorKey.currentContext!, '/modify/profile');
      },
    );
  }

  startTravel(context) async {
    int timelineId = await TimelineRepository().startTravel(context);
    userInfo.timeLineId = timelineId;
    notifyListeners();
    _goToTravelingTimelinePage(timelineId);
  }

  _goToTravelingTimelinePage(int timelineId) {
    pageController.jumpToPage(1);
    currentIndex = 1;
    notifyListeners();
    Timer(
      const Duration(milliseconds: 100),
      () {
        Navigator.popAndPushNamed(
            myFeedNavigatorKey.currentContext!, '/timeline/detail/$timelineId');
      },
    );
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
        pageBuilder: (_, __, ___) => HomeFeedPage(),
        transitionDuration: Duration.zero,
      );
    }
  }

  onMyFeedRoute(context, settings) {
    Widget page;
    if (settings.name!.startsWith('/timeline/detail')) {
      final timelineId = int.parse(settings.name.split('/')[3]);
      page = ChangeNotifierProvider(
        create: (_) => TimelineDetailViewModel(context, timelineId),
        child: TimelineDetailPage(),
      );
    } else if (settings.name == '/modify/profile') {
      page = ModifyProfile();
    } else {
      page = MultiProvider(
        providers: [
          ChangeNotifierProvider<MyFeedViewModel>(
            create: (_) => MyFeedViewModel(
                context: context, myInfo: userInfo, userInfo: userInfo),
          ),
          ChangeNotifierProvider<SearchBarViewModel>(
            create: (_) => SearchBarViewModel(isMyFeed: true),
          ),
        ],
        child: MyFeedView(),
      );
    }
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
    );
  }

  changeTitle(String newTitle) {
    _formerTitle.push(_title);
    _title = newTitle;
    notifyListeners();
  }

  changeTitleToFormer() {
    String? tmp = _formerTitle.pop();
    if (tmp != null) _title = tmp;
    notifyListeners();
  }
}

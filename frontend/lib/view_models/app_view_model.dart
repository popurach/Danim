import 'dart:async';

import 'package:danim/view_models/my_timeline_list_view_model.dart';
import 'package:danim/view_models/timeline_detail_view_model.dart';
import 'package:danim/views/my_timeline_list_view.dart';
import 'package:danim/views/timeline_detail_page.dart';
import 'package:danim/views/timeline_list_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../models/UserInfo.dart';
import '../views/modify_profile.dart';

class AppViewModel with ChangeNotifier {
  int currentIndex;
  final pageController = PageController(initialPage: 0);
  final GlobalKey<NavigatorState> homeFeedNavigatorKey = GlobalKey();
  final GlobalKey<NavigatorState> myFeedNavigatorKey = GlobalKey();
  String _imageUrl = '';
  String _nickname = '';
  int _userUid = 0;

  final logger = Logger();

  AppViewModel(this._imageUrl, this._nickname, this._userUid,
      {this.currentIndex = 0});

  String get imageUrl => _imageUrl;

  void changePage(index) {
    pageController.jumpToPage(index);
    currentIndex = index;
    notifyListeners();
  }

  updateUserInfo(UserInfo userInfo) {
    _imageUrl = userInfo.profileImageUrl;
    _nickname = userInfo.nickname;
    _userUid = userInfo.userUid;
    notifyListeners();
  }

  goModifyProfilePage() {
    pageController.jumpToPage(1);
    currentIndex = 1;
    notifyListeners();
    Timer(
      const Duration(milliseconds: 100),
      () {
        Navigator.pushNamed(
            myFeedNavigatorKey.currentContext!, '/modify/profile');
      },
    );
  }

  logout(BuildContext context) {
    // const storage = FlutterSecureStorage();
    // storage.deleteAll();
    // logger.d('context of logout');
    // logger.d(context);
    // Navigator.pushReplacement(
    //   context,
    //   PageRouteBuilder(
    //     pageBuilder: (_, __, ___) => LoginPage(),
    //   ),
    // );
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
      page = ChangeNotifierProvider<MyTimeLineListViewModel>(
        create: (_) => MyTimeLineListViewModel(),
        child: MyTimeLineListView(),
      );
    }
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
    );
  }

  String get nickname => _nickname;

  int get userUid => _userUid;
}

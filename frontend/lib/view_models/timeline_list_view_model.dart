import 'package:danim/models/Timeline.dart';
import 'package:danim/services/timeline_repository.dart';
import 'package:danim/services/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../models/UserInfo.dart';
import 'app_view_model.dart';

class TimelineListViewModel with ChangeNotifier {
  int? userUid;
  String? profileImageUrl;
  String? nickname;
  AppViewModel? appViewModel;

  final PagingController<int, Timeline> pagingController =
  PagingController(firstPageKey: 0);


  TimelineListViewModel({required BuildContext context, this.userUid, this.profileImageUrl, this.nickname, this.appViewModel}) {
    if (userUid == null) {
      pagingController.addPageRequestListener((pageKey) {
        getMainTimelineList(context, pageKey);
      });
    } else {
      if (appViewModel != null) {
        if (appViewModel?.userUid == userUid) {
          pagingController.addPageRequestListener((pageKey) {
            getMyTimelineList(context, pageKey);
          });
          } else {
          pagingController.addPageRequestListener((pageKey) {
            getOtherTimelineList(context, pageKey, userUid);
          }
          );
        }
      }
    }
  }

  Future<void> getMainTimelineList(BuildContext context, int pageKey) async {
    try {
      final newItems =
      await TimelineRepository().getMainTimelineByPageNum(context, pageKey);
      final isLastPage = newItems.length < 15;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
      notifyListeners();
    } catch (e) {
      throw Exception('get timeline list fail: $e');
    }
  }

    Future<void> getMyTimelineList(BuildContext context, int pageKey) async {
      try {
        final newItems =
        await TimelineRepository().getMyTimelineByPageNum(
            context, pageKey);
        final isLastPage = newItems.length < 15;
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + newItems.length;
          pagingController.appendPage(newItems, nextPageKey);
        }
        notifyListeners();
      } catch (e) {
        throw Exception('get timeline list fail: $e');
      }
      notifyListeners();
    }

  Future<void> getOtherTimelineList(BuildContext context, int pageKey, userUid) async {
      final newItems =
      await TimelineRepository().getOtherTimelineByPageNum(
          context, pageKey, userUid);
      final isLastPage = newItems.length < 15;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
      notifyListeners();

    notifyListeners();
  }

    @override
    void dispose() {
      pagingController.dispose();
      super.dispose();
    }
  }


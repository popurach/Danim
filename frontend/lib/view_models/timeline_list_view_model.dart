import 'package:danim/models/Timeline.dart';
import 'package:danim/services/timeline_repository.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'app_view_model.dart';

class TimelineListViewModel with ChangeNotifier {
  int userUid;
  int? myUid;

  final PagingController<int, Timeline> pagingController =
  PagingController(firstPageKey: 0);

  TimelineListViewModel(
      {required BuildContext context, this.userUid=-1, this.myUid}) {
    if (userUid == -1) {
      pagingController.addPageRequestListener((pageKey) {
        getMainTimelineList(context, pageKey);
      });
    } else if (userUid != -1 && myUid != null) {
      if (userUid == myUid) {
        pagingController.addPageRequestListener((pageKey) {
          getMyTimelineList(context, pageKey);
        });
      } else {
        pagingController.addPageRequestListener((pageKey) {
          getUserTimelineList(context, pageKey);
        });
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
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
      notifyListeners();
    } catch (e) {
      throw Exception('get timeline list fail: $e');
    }
  }

  Future<void> getUserTimelineList(BuildContext context, int pageKey) async {
    final newItems = await TimelineRepository()
        .getOtherTimelineByPageNum(context, pageKey, userUid);
    final isLastPage = newItems.length < 15;
    if (isLastPage) {
      pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = pageKey + 1;
      pagingController.appendPage(newItems, nextPageKey);
    }
    notifyListeners();
  }

  Future<void> getMyTimelineList(BuildContext context, int pageKey) async {
    final newItems = await TimelineRepository()
        .getMyTimelineByPageNum(context, pageKey);
    final isLastPage = newItems.length < 15;
    if (isLastPage) {
      pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = pageKey + 1;
      pagingController.appendPage(newItems, nextPageKey);
    }
    notifyListeners();
  }

  refresh(context) async {
    pagingController.refresh();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}

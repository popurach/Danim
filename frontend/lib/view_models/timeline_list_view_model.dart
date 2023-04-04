import 'package:danim/models/Timeline.dart';
import 'package:danim/services/timeline_repository.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'app_view_model.dart';

class TimelineListViewModel with ChangeNotifier {
  int userUid;
  String? profileImageUrl;
  String? nickname;
  AppViewModel? appViewModel;

  final PagingController<int, Timeline> pagingController =
      PagingController(firstPageKey: 0);

  TimelineListViewModel(
      {required BuildContext context,
      this.userUid = -1,
      this.profileImageUrl,
      this.nickname,
      this.appViewModel}) {
    if (userUid == -1) {
      pagingController.addPageRequestListener((pageKey) {
        getMainTimelineList(context, pageKey);
      });
    } else {
      // 내 페이지가 아니면
      pagingController.addPageRequestListener((pageKey) {
        getUserTimelineList(context, pageKey);
      });
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

  refresh(context) async {
    pagingController.refresh();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}

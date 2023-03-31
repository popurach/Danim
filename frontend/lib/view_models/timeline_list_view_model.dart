import 'package:danim/models/Timeline.dart';
import 'package:danim/services/timeline_repository.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TimelineListViewModel with ChangeNotifier {
  final userUid;
  final PagingController<int, Timeline> pagingController =
      PagingController(firstPageKey: 0);

  TimelineListViewModel({required BuildContext context, this.userUid}) {
    if (userUid == null) {
      pagingController.addPageRequestListener((pageKey) {
        getMainTimelineList(context, pageKey);
      });
    } else {
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
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
      notifyListeners();
    } catch (e) {
      throw Exception('get timeline list fail: $e');
    }
  }

  Future<void> getUserTimelineList(BuildContext context, int pageKey) async {
    // TODO 유저 타임 라인 리스트 가져오기
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
    notifyListeners();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}

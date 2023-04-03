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

  final PagingController<int, Timeline> pagingController =
  PagingController(firstPageKey: 0);


  TimelineListViewModel({required BuildContext context, this.userUid, this.profileImageUrl, this.nickname}) {
    if (userUid == null) {
      pagingController.addPageRequestListener((pageKey) {
        getMainTimelineList(context, pageKey);
      });
    } else {
      // 내 페이지가 아니면
      pagingController.addPageRequestListener((pageKey) {
        getUserTimelineList(context, pageKey);
      }
      );
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
        await TimelineRepository().getUserTimelineByPageNum(
            context, pageKey, userUid);
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


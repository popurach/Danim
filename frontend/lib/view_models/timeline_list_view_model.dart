import 'package:danim/models/Timeline.dart';
import 'package:danim/services/timeline_repository.dart';
import 'package:flutter/material.dart';

class TimelineListViewModel with ChangeNotifier {
  List<Timeline> _timelineList = [];
  final userUid;
  int pageNum = 0;

  TimelineListViewModel({this.userUid}) {
    if (userUid == null) {
      getMainTimelineList();
    } else {
      getUserTimelineList();
    }
  }

  List<Timeline> get timelineList => _timelineList;

  Future<void> getMainTimelineList() async {
    try {
      final data =
          await TimelineRepository().getMainTimelineByPageNum(pageNum++);
      _timelineList = [..._timelineList, ...data];
      notifyListeners();
    } catch (e) {
      throw Exception('get timeline list fail: $e');
    }
  }

  Future<void> getUserTimelineList() async {
    // TODO 유저 타임 라인 리스트 가져오기
    // final data = await TimelineRepository().getMainTimelineByPageNum(pageNum++);
    // _timelineList = [..._timelineList, ...data];
    notifyListeners();
  }

  @override
  void dispose() {
    _timelineList = [];
    super.dispose();
  }
}

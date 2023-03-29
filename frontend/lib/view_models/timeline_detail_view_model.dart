import 'package:danim/services/timeline_repository.dart';
import 'package:flutter/widgets.dart';

import '../models/TimelineDetail.dart';

class TimelineDetailViewModel extends ChangeNotifier {
  final int timelineId;
  List<TimelineDetail> _timelineDetails = [];

  List<TimelineDetail> get timelineDetails => _timelineDetails;

  TimelineDetailViewModel(BuildContext context, this.timelineId) {
    loadTimelineDetails(context);
  }

  loadTimelineDetails(context) async {
    _timelineDetails = await TimelineRepository()
        .getTimelineDetailsByTimelineId(context, timelineId);
    notifyListeners();
  }

  changeExpansions(int timelineIndex, bool isExpand) async {
    if (!isExpand) {
      await Future.delayed(const Duration(milliseconds: 100));
      for (var post in _timelineDetails[timelineIndex].postList) {
        post.isExpand = false;
      }
    }
    _timelineDetails[timelineIndex].isExpand = isExpand;
    notifyListeners();
  }

  changePostExpansion(int timelineIndex, int postIndex, bool isExpand) async {
    if (!isExpand) {
      await Future.delayed(const Duration(milliseconds: 200));
    }
    _timelineDetails[timelineIndex].postList[postIndex].isExpand = isExpand;
    notifyListeners();
  }
}

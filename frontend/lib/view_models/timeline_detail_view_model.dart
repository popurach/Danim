import 'package:danim/services/timeline_repository.dart';
import 'package:flutter/widgets.dart';

import '../models/TimelineDetail.dart';

class TimelineDetailViewModel extends ChangeNotifier {
  final int timelineId;
  final int expansionTileAnimationTile = 200;
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
      await Future.delayed(Duration(milliseconds: expansionTileAnimationTile));
      for (var post in _timelineDetails[timelineIndex].postList) {
        post.isExpand = false;
      }
    }
    _timelineDetails[timelineIndex].isExpand = isExpand;
    notifyListeners();
  }

  changePostExpansion(int timelineIndex, int postIndex, bool isExpand) async {
    if (!isExpand) {
      await Future.delayed(Duration(milliseconds: expansionTileAnimationTile!));
    }
    _timelineDetails[timelineIndex].postList[postIndex].isExpand = isExpand;
    notifyListeners();
  }

  void scrollToSelectedContent(context) {
    if (context != null) {
      Future.delayed(Duration(milliseconds: expansionTileAnimationTile))
          .then((value) {
        Scrollable.ensureVisible(context,
            duration: Duration(milliseconds: expansionTileAnimationTile));
      });
    }
  }
}

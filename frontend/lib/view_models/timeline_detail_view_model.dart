import 'package:danim/services/timeline_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

import '../models/TimelineDetail.dart';

class TimelineDetailViewModel extends ChangeNotifier {
  final int timelineId;
  bool _isMine = false;
  bool _isPublic = false;
  final int expansionTileAnimationTile = 200;
  List<TimelineDetail> _timelineDetails = [];

  get isMine => _isMine;
  get isPublic => _isPublic;
  get timelineDetails => _timelineDetails;

  TimelineDetailViewModel(BuildContext context, this.timelineId) {
    loadTimelineDetails(context);
  }

  loadTimelineDetails(context) async {
    final timelineInfo = await TimelineRepository()
        .getTimelineDetailsByTimelineId(context, timelineId);
    _timelineDetails = timelineInfo.timelineDetails;
    _isMine = _timelineDetails[0].isMine;
    _isPublic = timelineInfo.isPublic;
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

  showPublicIcon() {
    if (_isMine) {
      if (_isPublic) {
        return const Icon(Icons.lock);
      } else {
        return const Icon(Icons.lock_open);
      }
    }
    return Container();
  }
}

import 'package:danim/services/timeline_repository.dart';
import 'package:flutter/widgets.dart';

import '../models/TimelineDetail.dart';

class TimelineDetailViewModel extends ChangeNotifier {
  final int timelineId;
  List<TimelineDetail> timelineDetails = [];

  TimelineDetailViewModel(BuildContext context, this.timelineId) {
    loadTimelineDetails(context);
  }

  loadTimelineDetails(context) async {
    timelineDetails = await TimelineRepository()
        .getTimelineDetailsByTimelineId(context, timelineId);
    notifyListeners();
  }
}

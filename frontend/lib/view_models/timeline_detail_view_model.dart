import 'package:flutter/cupertino.dart';

class TimelineDetailViewModel with ChangeNotifier {
  final int _timelineId;

  TimelineDetailViewModel({required int timelineId}) : _timelineId = timelineId;

  // TODO get timeline data from server
}

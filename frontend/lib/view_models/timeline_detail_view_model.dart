import 'package:danim/models/Timeline.dart';
import 'package:danim/services/user_repository.dart';
import 'package:flutter/cupertino.dart';

import '../models/Post.dart';

class TimelineDetailViewModel with ChangeNotifier {
  final int _timelineId;
  Timeline? _timeline;

  Timeline? get timeline => _timeline;

  setTimeline() async {
    _timeline = await UserRepository().getTimelineById(_timelineId);
  }

  TimelineDetailViewModel(this._timelineId) {
    // setTimeline();
    _timeline = Timeline(
        timelineId: 0,
        userId: 0,
        title: 'title1',
        createTime: "21.02.01",
        modifyTime: "21.02.28",
        complete: true,
        imageUrl: "https://picsum.photos/id/10/500/500.jpg",
        timelinePublic: true,
        post: [
          Post(
              imageUrls: [
                'https://picsum.photos/id/10/1000/1000',
                'https://picsum.photos/id/11/1000/1000',
                'https://picsum.photos/id/12/1000/1000',
                'https://picsum.photos/id/13/1000/1000'
              ],
              voiceUrl: 'voiceUrl',
              voiceLength: '00:15',
              text: '여기가 어디요..',
              isLike: false)
        ]);
  }

// TODO get timeline data from server
}

import 'package:flutter/material.dart';

import 'package:danim/view_models/search_bar_view_model.dart';
import 'package:danim/models/Timeline.dart';
import 'package:danim/models/Post.dart';


class MyTimeLineListViewModel extends ChangeNotifier {
  late SearchBarViewModel searchBarViewModel;
  List<Timeline> _mytimelineList = [];

  Future<void> _initialize() async {
    // final data = await UserRepository().getMainTimeline();
    // _timelineList = data;
    _mytimelineList = [
      Timeline(
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
                  'https://picsum.photos/id/10/500/500.jpg',
                  'https://picsum.photos/id/10/500/500.jpg'
                ],
                voiceUrl: 'voiceUrl',
                voiceLength: '23:11',
                text: '여기가 어디요..',
                isLike: false)
          ]),
      Timeline(
          timelineId: 1,
          userId: 1,
          title: 'title2',
          createTime: "21.02.01",
          modifyTime: "21.02.28",
          complete: true,
          imageUrl: "https://picsum.photos/id/13/500/500.jpg",
          timelinePublic: true,
          post: [
            Post(
                imageUrls: [
                  'https://picsum.photos/id/10/500/500.jpg',
                  'https://picsum.photos/id/10/500/500.jpg'
                ],
                voiceUrl: 'voiceUrl',
                voiceLength: '23:11',
                text: '여기가 어디요..',
                isLike: false)
          ]),
      Timeline(
          timelineId: 2,
          userId: 2,
          title: 'title3',
          createTime: "21.02.01",
          modifyTime: "21.02.28",
          complete: true,
          imageUrl: "https://picsum.photos/id/16/500/500.jpg",
          timelinePublic: true,
          post: [
            Post(
                imageUrls: [
                  'https://picsum.photos/id/10/500/500.jpg',
                  'https://picsum.photos/id/10/500/500.jpg'
                ],
                voiceUrl: 'voiceUrl',
                voiceLength: '23:11',
                text: '여기가 어디요..',
                isLike: false)
          ]),
    ];
    // for (var timeline in _timelineList) {
    //   await _generatePalette(timeline);
    // }
    notifyListeners();
  }

  MyTimeLineListViewModel() {
    searchBarViewModel = searchBarViewModel;
    _initialize();
  }

  List<Timeline> get mytimelineList => _mytimelineList;

  @override
  void dispose() {
    _mytimelineList = [];
    super.dispose();
  }
}
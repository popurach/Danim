import 'package:danim/models/Post.dart';
import 'package:danim/models/Timeline.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:palette_generator/palette_generator.dart';

class TimelineListViewModel with ChangeNotifier {
  List<Timeline> _timelineList = [];
  List<PaletteGenerator> paletteGeneratorList = [];
  var logger = Logger();

  Future<void> _initialize() async {
    // final data = await UserRepository().getMainTimeline();
    // _timelineList = data;
    _timelineList = [
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

  TimelineListViewModel() {
    _initialize();
  }

  // Future<void> _generatePalette(Timeline timeline) async {
  //   try {
  //     final response = await Dio().get(timeline.imageUrl,
  //         options: Options(responseType: ResponseType.bytes));
  //     final image = Image.memory(response.data);
  //     // final imageProvider = NetworkImage(timeline.imageUrl);
  //     final paletteGenerator =
  //         await PaletteGenerator.fromImageProvider(image.image);
  //     paletteGeneratorList.add(paletteGenerator);
  //     notifyListeners();
  //   } catch (e) {
  //     // Handle any errors thrown by PaletteGenerator.fromImageProvider
  //     logger.e('Error generating palette for ${timeline.imageUrl}: $e');
  //   }
  // }

  List<Timeline> get timelineList => _timelineList;

  @override
  void dispose() {
    _timelineList = [];
    super.dispose();
  }
}

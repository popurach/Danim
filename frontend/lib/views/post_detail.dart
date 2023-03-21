import 'package:danim/module/audio_player_view.dart';
import 'package:danim/view_models/images_page_view_model.dart';
import 'package:danim/view_models/post_view_model.dart';
import 'package:danim/views/images_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../module/audio_player_view_model.dart';

class PostDetail extends StatelessWidget {
  final PostViewModel viewModel;

  const PostDetail({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 52,
            height: 500,
            child: TimelineTile(
              indicatorStyle: const IndicatorStyle(
                  width: 0, padding: EdgeInsets.only(left: 10)),
              alignment: TimelineAlign.center,
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width - 72,
          height: 500,
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            insetPadding: const EdgeInsets.all(5),
                            child: ChangeNotifierProvider(
                              create: (_) =>
                                  ImagesPageViewModel(viewModel.post.imageUrls),
                              child: ImagesPageView(),
                            ),
                          );
                        });
                  },
                  child: ChangeNotifierProvider(
                    create: (_) =>
                        ImagesPageViewModel(viewModel.post.imageUrls),
                    child: const ImagesPageView(),
                  ),
                ),
              ),
              ChangeNotifierProvider(
                create: (_) => AudioPlayerViewModel(viewModel.post.voiceUrl),
                child: AudioPlayerView(),
              ),
              Text(viewModel.post.text)
            ],
          ),
        ),
      ],
    );
  }
}

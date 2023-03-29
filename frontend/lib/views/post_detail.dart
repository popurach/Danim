import 'package:danim/models/Post.dart';
import 'package:danim/module/audio_player_view.dart';
import 'package:danim/view_models/images_page_view_model.dart';
import 'package:danim/views/images_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../module/audio_player_view_model.dart';

class PostDetail extends StatelessWidget {
  final Post post;

  const PostDetail({super.key, required this.post});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings),
                  ),
                ],
              ),
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
                                  ImagesPageViewModel(post.photoList),
                              child: const ImagesPageView(),
                            ),
                          );
                        });
                  },
                  child: ChangeNotifierProvider(
                    create: (_) => ImagesPageViewModel(post.photoList),
                    child: const ImagesPageView(),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_outline,
                        color: post.isFavorite
                            ? Colors.pinkAccent
                            : Colors.black12,
                      ),
                    ),
                    Text(post.favoriteCount.toString()),
                  ],
                ),
              ),
              ChangeNotifierProvider(
                create: (_) => AudioPlayerViewModel(post.voiceUrl),
                child: AudioPlayerView(),
              ),
              Text(post.text)
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:danim/view_models/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(builder: (context, viewModel, child) {
      return Row(
        children: [
          SizedBox(
              width: 52,
              height: 400,
              child: TimelineTile(
                indicatorStyle: const IndicatorStyle(width: 0),
                alignment: TimelineAlign.center,
              )),
          SizedBox(
            height: 400,
            width: 400,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: viewModel.controller,
                    children: viewModel.cachedImagedList,
                  ),
                ),
                Text(viewModel.post.text)
              ],
            ),
          ),
        ],
      );
    });
  }
}

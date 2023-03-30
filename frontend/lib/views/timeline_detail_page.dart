import 'package:cached_network_image/cached_network_image.dart';
import 'package:danim/view_models/post_view_model.dart';
import 'package:danim/view_models/timeline_detail_view_model.dart';
import 'package:danim/views/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TimelineDetailViewModel>(
        builder: (context, viewModel, _) => SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 5),
                physics: const ClampingScrollPhysics(),
                itemCount:
                    viewModel.timelineDetails.length, // Number of nations
                itemBuilder: (BuildContext context, int timelineIndex) {
                  return ExpansionTile(
                    tilePadding: const EdgeInsets.only(left: 5),
                    shape: const RoundedRectangleBorder(),
                    collapsedShape: const RoundedRectangleBorder(),
                    onExpansionChanged: (isExpand) {
                      viewModel.changeExpansions(timelineIndex, isExpand);
                    },
                    title: Text(
                      viewModel.timelineDetails[timelineIndex].nation,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    trailing: null,
                    leading: SizedBox(
                      width: 60,
                      height: 60,
                      child: TimelineTile(
                        alignment: TimelineAlign.manual,
                        isFirst: timelineIndex == 0,
                        isLast: (timelineIndex ==
                                viewModel.timelineDetails.length - 1) &&
                            (!viewModel
                                .timelineDetails[timelineIndex].isExpand),
                        lineXY: 0.1,
                        indicatorStyle: IndicatorStyle(
                          width: 40,
                          height: 40,
                          indicator: CachedNetworkImage(
                            imageUrl:
                                viewModel.timelineDetails[timelineIndex].flag,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.timelineDetails[timelineIndex]
                            .postList.length, // Number of nations
                        itemBuilder: (BuildContext context, int postIndex) {
                          return ExpansionTile(
                            shape: const RoundedRectangleBorder(),
                            collapsedShape: const RoundedRectangleBorder(),
                            tilePadding: const EdgeInsets.only(left: 5),
                            onExpansionChanged: (isExpand) {
                              viewModel.changePostExpansion(
                                  timelineIndex, postIndex, isExpand);
                            },
                            title: Text(viewModel.timelineDetails[timelineIndex]
                                .postList[postIndex].address),
                            leading: SizedBox(
                              width: 60,
                              height: 60,
                              child: TimelineTile(
                                isLast: (timelineIndex ==
                                        viewModel.timelineDetails.length - 1) &&
                                    (postIndex ==
                                        viewModel.timelineDetails[timelineIndex]
                                                .postList.length -
                                            1) &&
                                    (!viewModel.timelineDetails[timelineIndex]
                                        .postList[postIndex].isExpand),
                                indicatorStyle: const IndicatorStyle(
                                    width: 20,
                                    color: Colors.lightBlue,
                                    padding: EdgeInsets.only(left: 10)),
                                endChild: Container(
                                  padding: const EdgeInsets.all(8),
                                ),
                              ),
                            ),
                            children: [
                              ChangeNotifierProvider(
                                create: (_) => PostViewModel(viewModel
                                    .timelineDetails[timelineIndex]
                                    .postList[postIndex]),
                                child: PostDetail(
                                  key: Key(viewModel
                                      .timelineDetails[timelineIndex]
                                      .postList[postIndex]
                                      .postId
                                      .toString()),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('여행 종료'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

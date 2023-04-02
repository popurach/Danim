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
              viewModel.isMine
                  ? Row(
                      children: [
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(viewModel.isPublic ? '공개' : ' 비공개'),
                        ),
                        viewModel.showPublicIcon(),
                        Switch(
                            value: viewModel.isPublic,
                            onChanged: (_) {
                              viewModel.changeIsPublic(context);
                            }),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('타임라인 삭제'),
                                content: const Text('타임라인을  삭제하시겠습니까?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      '삭제',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('취소'),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    )
                  : Container(),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 5),
                physics: const ClampingScrollPhysics(),
                itemCount: viewModel.timelineDetails.length,
                // Number of nations
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
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Text(
                        '${viewModel.timelineDetails[timelineIndex].startDate} ~ ${viewModel.timelineDetails[timelineIndex].finishDate}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
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
                        itemCount: viewModel
                            .timelineDetails[timelineIndex].postList.length,
                        // Number of nations
                        itemBuilder: (BuildContext context, int postIndex) {
                          return ExpansionTile(
                            shape: const RoundedRectangleBorder(),
                            collapsedShape: const RoundedRectangleBorder(),
                            tilePadding: const EdgeInsets.only(left: 5),
                            onExpansionChanged: (isExpand) {
                              viewModel.changePostExpansion(
                                  timelineIndex, postIndex, isExpand);
                            },
                            title: Text(
                              viewModel.timelineDetails[timelineIndex]
                                  .postList[postIndex].address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                                create: (_) => PostViewModel(
                                    viewModel.timelineDetails[timelineIndex]
                                        .postList[postIndex],
                                    viewModel.isMine),
                                child: PostDetail(
                                  key: Key(
                                    viewModel.timelineDetails[timelineIndex]
                                        .postList[postIndex].postId
                                        .toString(),
                                  ),
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
              viewModel.isMine && !viewModel.isComplete
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('여행 제목을 입력해 주세요'),
                                content: TextField(
                                  controller: viewModel.textController,
                                  onChanged: (value) {
                                    viewModel.title = value;
                                  },
                                  decoration: InputDecoration(
                                    labelText: '제목',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      viewModel.endTimeline(context);
                                    },
                                    child: const Text(
                                      '여행 종료',
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      viewModel.resetTitle();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('취소'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text(
                            '여행 종료',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

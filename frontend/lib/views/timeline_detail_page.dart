import 'package:cached_network_image/cached_network_image.dart';
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
        builder: (context, viewModel, _) => ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: viewModel.timelineDetails.length, // Number of nations
          itemBuilder: (BuildContext context, int index) {
            return ExpansionTile(
              shape: const RoundedRectangleBorder(),
              collapsedShape: const RoundedRectangleBorder(),
              title: Text(viewModel.timelineDetails[index].nation),
              trailing: null,
              leading: SizedBox(
                width: 60,
                height: 60,
                child: TimelineTile(
                  alignment: TimelineAlign.manual,
                  isFirst: index == 0,
                  lineXY: 0.1,
                  // isFirst: true,
                  indicatorStyle: IndicatorStyle(
                    width: 30,
                    indicator: CachedNetworkImage(
                      imageUrl: viewModel.timelineDetails[index].flag,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              children: [
                ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: viewModel.timelineDetails[index].postList
                        .length, // Number of nations
                    itemBuilder: (BuildContext context, int idx) {
                      return ExpansionTile(
                        shape: const RoundedRectangleBorder(),
                        collapsedShape: const RoundedRectangleBorder(),
                        title: Text(''),
                        leading: SizedBox(
                          width: 60,
                          height: 60,
                          child: TimelineTile(
                            indicatorStyle: const IndicatorStyle(
                                width: 20,
                                color: Colors.lightBlue,
                                padding: EdgeInsets.only(left: 5)),
                            endChild: Container(
                              padding: const EdgeInsets.all(8),
                            ),
                          ),
                        ),
                        children: [
                          PostDetail(
                              post: viewModel
                                  .timelineDetails[index].postList[idx]),
                        ],
                      );
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}

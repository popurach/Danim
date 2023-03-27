import 'package:danim/view_models/app_view_model.dart';
import 'package:danim/view_models/post_view_model.dart';
import 'package:danim/view_models/timeline_detail_view_model.dart';
import 'package:danim/views/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TimelineDetailViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 3, // Number of nations
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                shape: const RoundedRectangleBorder(),
                collapsedShape: const RoundedRectangleBorder(),
                title: Text('Nation $index'),
                trailing: null,
                leading: SizedBox(
                  width: 60,
                  height: 60,
                  child: TimelineTile(
                    alignment: TimelineAlign.manual,
                    isFirst: index == 0,
                    lineXY: 0.1,
                    // isFirst: true,
                    indicatorStyle: const IndicatorStyle(
                      width: 30,
                      color: Colors.purple,
                    ),
                    endChild: Container(
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ),
                children: [
                  ExpansionTile(
                    shape: const RoundedRectangleBorder(),
                    collapsedShape: const RoundedRectangleBorder(),
                    title: const Text('city A'),
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
                          viewModel: PostViewModel(viewModel.timeline!.post[0]))
                    ],
                  ),
                  ExpansionTile(
                    shape: const RoundedRectangleBorder(),
                    collapsedShape: const RoundedRectangleBorder(),
                    title: const Text('city B'),
                    leading: SizedBox(
                      width: 60,
                      height: 60,
                      child: TimelineTile(
                        indicatorStyle: const IndicatorStyle(
                          width: 20,
                          color: Colors.lightBlueAccent,
                          padding: EdgeInsets.only(left: 5),
                        ),
                        endChild: Container(
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:danim/views/timeline_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/timeline_list_view_model.dart';

class TimeLineList extends StatelessWidget {
  const TimeLineList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimelineListViewModel>(
        create: (_) => TimelineListViewModel(),
        child: Consumer<TimelineListViewModel>(
            builder: (context, viewModel, child) => ListView.builder(
                itemCount: viewModel.timelineList.length,
                itemBuilder: (context, index) {
                  return TimelineListItem(viewModel.timelineList[index]);
                })));
  }
}

import 'package:danim/views/timeline_list_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../models/Timeline.dart';
import '../view_models/timeline_list_view_model.dart';

class TimelineListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<TimelineListViewModel>(
        create: (_) => TimelineListViewModel(context: context),
        child: Consumer<TimelineListViewModel>(
          builder: (context, viewModel, child) => Padding(
            padding: const EdgeInsets.only(bottom: 33),
            child: PagedListView<int, Timeline>(
              pagingController: viewModel.pagingController,
              builderDelegate: PagedChildBuilderDelegate<Timeline>(
                itemBuilder: (context, item, index) => TimelineListItem(
                  key: Key(item.timelineId.toString()),
                  timeline: item,
                ),
              ),
            ),
          ),
        ),
      );
}

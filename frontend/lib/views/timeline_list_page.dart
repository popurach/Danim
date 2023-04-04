import 'package:danim/view_models/app_view_model.dart';
import 'package:danim/views/timeline_list_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../models/Timeline.dart';
import '../view_models/timeline_list_view_model.dart';

class TimelineListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Consumer<AppViewModel>(builder: (_, appViewModel, __) {
        return ChangeNotifierProvider<TimelineListViewModel>(
          create: (_) => TimelineListViewModel(context: context),
          child: Consumer<TimelineListViewModel>(
            builder: (context, viewModel, child) => RefreshIndicator(
              onRefresh: () async {
                viewModel.refresh(context);
              },
              child: PagedListView<int, Timeline>(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
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
      });
}
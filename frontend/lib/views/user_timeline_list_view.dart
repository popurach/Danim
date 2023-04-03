import 'package:cached_network_image/cached_network_image.dart';
import 'package:danim/models/Timeline.dart';
import 'package:danim/view_models/search_bar_view_model.dart';
import 'package:danim/views/search_bar_view.dart';
import 'package:danim/views/timeline_list_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../view_models/timeline_list_view_model.dart';

class UserTimeLineListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SearchBarViewModel())],
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          child: Consumer<TimelineListViewModel>(
            builder: (_, timelineViewModel, child) => LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
                    onTap: () {
                      final searchBarViewModel =
                      Provider.of<SearchBarViewModel>(context, listen: false);
                      searchBarViewModel.searchedResults = [];
                    },
                    child: Stack(
                      children: [
                        // 검색창과 그 결과 부분을 제외한 부분을 터치하면 포커스가 해제되고 키워드를 없애 검색창을 사라지게 한다.
                        Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 65),
                            child: Column(
                              children: [
                                // 개인 정보가 들어가는 칸
                                Container(
                                  height: 100,
                                  margin: const EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(color: Colors.black54)),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: CachedNetworkImage(
                                            imageUrl: timelineViewModel.profileImageUrl!,
                                          )),
                                      const Expanded(
                                          flex: 1,
                                          child: VerticalDivider(
                                              color: Colors.black54)),
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(timelineViewModel
                                                .nickname!),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text("text"),
                                                Text("text"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // 타임라인 리스트가 들어가는 칸
                                Expanded(
                                    child: PagedListView<int, Timeline>(
                                      pagingController:
                                      timelineViewModel.pagingController,
                                      builderDelegate:
                                      PagedChildBuilderDelegate<Timeline>(
                                        itemBuilder: (context, item, index) =>
                                            TimelineListItem(
                                              key: Key(item.timelineId.toString()),
                                              timeline: item,
                                            ),
                                      ),
                                    ))
                              ],
                            )),
                        Positioned(
                          top: 0, left: 0, right: 0, bottom: 0, child:
                        Container(
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          child: ChangeNotifierProvider<SearchBarViewModel>(
                            create: (_) => SearchBarViewModel(userUid: timelineViewModel.userUid),
                            child: SearchBar(),
                          ),
                        ),),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

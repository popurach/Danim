import 'package:danim/view_models/app_view_model.dart';
import 'package:danim/view_models/search_bar_view_model.dart';
import 'package:danim/view_models/user_timeline_list_view_model.dart';
import 'package:danim/views/search_bar_view.dart';
import 'package:danim/views/timeline_list_page.dart';
import 'package:danim/views/user_information_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/timeline_list_view_model.dart';

class UserTimeLineListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchBarViewModel()),
      ],
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          child: Consumer<AppViewModel>(
            builder: (_, appViewModel, child) {
              return Consumer<UserTimelineListViewModel>(
                builder: (context, userTimelineListViewModel, child) {
                  return LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return GestureDetector(
                        onTap: () {},
                        child: Stack(
                          children: [
                            // 검색창과 그 결과 부분을 제외한 부분을 터치하면 포커스가 해제되고 키워드를 없애 검색창을 사라지게 한다.
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 55.0),
                              child: Column(
                                children: [
                                  // 개인 정보가 들어가는 칸
                                  ChangeNotifierProvider(
                                    create: (_) => UserTimelineListViewModel(
                                      context: context,
                                      myInfo: userTimelineListViewModel.myInfo,
                                      userInfo:
                                          userTimelineListViewModel.userInfo,
                                    ),
                                    child: UserInformationView(),
                                  ),
                                  // 타임라인 리스트가 들어가는 칸
                                  Expanded(
                                    child: ChangeNotifierProvider(
                                      create: (_) => TimelineListViewModel(
                                        context: context,
                                        userUid: userTimelineListViewModel
                                            .userInfo.userUid,
                                        myUid: userTimelineListViewModel
                                            .myInfo.userUid,
                                      ),
                                      child: TimelineListPage(
                                        pagingController:
                                            userTimelineListViewModel
                                                .pagingController,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // 여행 시작 버튼
                            Positioned(
                              top: constraints.maxHeight * 0.8,
                              left: constraints.maxWidth * 0.8,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    "다님 시작",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child:
                                    ChangeNotifierProvider<SearchBarViewModel>(
                                  create: (_) => SearchBarViewModel(),
                                  child: SearchBar(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

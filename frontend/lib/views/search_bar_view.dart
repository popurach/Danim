import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:danim/view_models/app_view_model.dart';
import 'package:danim/view_models/search_result_view_model.dart';
import 'package:danim/view_models/timeline_list_view_model.dart';
import 'package:danim/views/search_result_page.dart';
import 'package:danim/views/user_timeline_list_view.dart';
import 'package:flutter/material.dart';

import 'package:danim/view_models/search_bar_view_model.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appViewModel = Provider.of<AppViewModel>(context, listen: false);
    return Consumer<SearchBarViewModel>(
      builder: (context, viewModel, _) {
        return Stack(
          children: [
            SizedBox(
              height: viewModel.searchedResults.isEmpty
                  ? (viewModel.searchedResults.length + 1) * 105
                  : viewModel.searchedResults.length == 1
                      ? (viewModel.searchedResults.length + 1) * 79
                      : (viewModel.searchedResults.length + 1) * 75,
              child: Column(
                children: [
                  // 키워드가 없을 때엔 검색 결과창이 뜨지 않는다.
                  viewModel.searchKeyWord != ""
                      ? Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(top: 30),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    top: BorderSide(
                                        color: Colors.transparent, width: 2),
                                    left: BorderSide(
                                        color: Colors.black54, width: 2),
                                    right: BorderSide(
                                        color: Colors.black54, width: 2),
                                    bottom: BorderSide(
                                        color: Colors.black54, width: 2),
                                  )),
                              child: Container(
                                margin: EdgeInsets.only(top: 14),
                                child: SizedBox(
                                  height:
                                      (viewModel.searchedResults.length + 1) *
                                          75,
                                  child: ListView.builder(
                                    itemCount:
                                        viewModel.searchedResults.length + 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index == 0) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChangeNotifierProvider<
                                                        SearchResultViewModel>(
                                                  create: (_) =>
                                                      SearchResultViewModel(
                                                          context,
                                                          viewModel
                                                              .searchKeyWord!,
                                                          userUid: viewModel
                                                              .userUid),
                                                  child: SearchResultView(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: ListTile(
                                              leading: Icon(Icons.search),
                                              title: Text(
                                                  "${viewModel.searchKeyWord}(으)로 검색...")),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChangeNotifierProvider<
                                                        TimelineListViewModel>(
                                                  create: (_) =>
                                                      TimelineListViewModel(
                                                          context: context,
                                                          userUid: viewModel
                                                              .searchedResults[
                                                                  index - 1]
                                                              .userUid,
                                                          profileImageUrl: viewModel
                                                              .searchedResults[
                                                                  index - 1]
                                                              .profileImageUrl,
                                                          nickname: viewModel
                                                              .searchedResults[
                                                                  index - 1]
                                                              .nickname,
                                                          appViewModel:
                                                              appViewModel),
                                                  child: UserTimeLineListView(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: ListTile(
                                            leading: SizedBox(
                                              height: 36,
                                              width: 36,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: viewModel
                                                        .searchedResults[
                                                            index - 1]
                                                        .profileImageUrl),
                                              ),
                                            ),
                                            title: Text(viewModel
                                                .searchedResults[index - 1]
                                                .nickname),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              )),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            // 검색창을 위에 띄우기 위해 children 내에서 뒤에 위치시킨다.
            Container(
              color: Colors.white,
              height: 45,
              child: TextFormField(
                focusNode: viewModel.myfocus,
                keyboardType: TextInputType.text,
                onChanged: (String? keyword) async {
                  viewModel.searchUser(context, keyword);
                },
                // 포커스 일 때 스타일 바꾸기
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black54, width: 2)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black54, width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 3),
                  ),
                  suffixIcon: Icon(Icons.search, color: Colors.blueAccent),
                  hintText: "검색...",
                  hintStyle: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

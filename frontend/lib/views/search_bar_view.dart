import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:danim/view_models/search_bar_view_model.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  final String parent;
  SearchBar({required this.parent});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBarViewModel>(builder: (context, viewModel, _) {
      return Stack(
        children: [
          ListView(
            children: [
              // 키워드가 없을 때엔 검색 결과창이 뜨지 않는다.
              viewModel.searchKeyWord != ""
                  ? Container(
                  margin: EdgeInsets.only(top: 30),
                  decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.transparent, width: 2),
                        left: BorderSide(color: Colors.black54, width: 2),
                        right: BorderSide(color: Colors.black54, width: 2),
                        bottom: BorderSide(color: Colors.black54, width: 2),
                      )),
                  child: Container(
                    margin: EdgeInsets.only(top: 14),
                    child: Container(
                      child: ListView.builder(
                          itemCount: viewModel.searchedResults.length +1 ,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return GestureDetector(
                                onTap: () {},
                                child: ListTile(
                                    leading: Icon(Icons.search),
                                    title: Text(
                                        "${viewModel.searchKeyWord}로 검색...")
                                ),
                              );
                            } else {
                              return ListTile(
                                leading: FlutterLogo(),
                                title: Text(viewModel.searchedResults[index-1].nickname),
                              );
                            }
                          }
                      ),
                    ),
                  ))
                  : const SizedBox.shrink(),
            ],
          ),
          // 검색창을 위에 띄우기 위해 children 내에서 뒤에 위치시킨다.
          Container(
            height: 45,
            child: TextFormField(
              focusNode: viewModel.myfocus,
              keyboardType: TextInputType.text,
              onChanged: (String? keyword) async {
                viewModel.searchUser(keyword);
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
    });
  }
}

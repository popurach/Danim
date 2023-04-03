import 'package:cached_network_image/cached_network_image.dart';
import 'package:danim/view_models/search_result_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/widgets.dart';

class SearchResultView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchResultViewModel>(builder: (context, viewModel, _) {
      return (viewModel.searchedPosts.isEmpty
          ? Center(child: Text("${viewModel.keyword} 지역에 대한 검색 결과가 없습니다."))
          : GridView.custom(
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 2),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                childCount: viewModel.searchedPosts.length,
                (BuildContext context, int index) {
                  return GridTile(
                    child: GestureDetector(
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Stack(children: [
                            CachedNetworkImage(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              fit: BoxFit.cover,
                              imageUrl:
                                  viewModel.searchedPosts[index].thumbnailUrl,
                            ),
                            Positioned(
                              top: 8.0,
                              left: 8.0,
                              child: Container(
                                height: 25,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 13,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 7),
                                      child: Text(
                                        "${viewModel.searchedPosts[index].favorite}",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]);
                        },
                      ),
                      onTap: () {
                        Navigator.pushNamed(context,
                            '/timeline/detail/${viewModel.searchedPosts[index].timelineId}');
                      },
                    ),
                  );
                },
              ),
            ));
    });
  }
}

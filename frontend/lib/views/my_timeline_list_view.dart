import 'package:danim/view_models/my_timeline_list_view_model.dart';
import 'package:danim/view_models/search_bar_view_model.dart';
import 'package:danim/views/search_bar_view.dart';
import 'package:danim/views/timeline_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTimeLineListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<MyTimeLineListViewModel>(
            create: (_) => MyTimeLineListViewModel(),
          ),
          ChangeNotifierProvider<SearchBarViewModel>(
            create: (_) => SearchBarViewModel(),
          ),
        ],
        child: GestureDetector(
          onTap: () {
            SearchBarViewModel().myfocus.unfocus();
          },
          child: Container(
            margin: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
            child: Consumer<MyTimeLineListViewModel>(
              builder: (context, viewModel, child) =>
                  Builder(
                      builder: (context) {
                        return Stack(
                          children: [
                            SizedBox(
                                child: SearchBar(parent: "MyTimelineList")
                            ),
                            // SingleChildScrollView(
                            //   child:
                            //     Container(
                            //       alignment: Alignment.center,
                            //       margin: EdgeInsets.only(top:65),
                            //       decoration: BoxDecoration(
                            //         border: Border.all(
                            //           color: Colors.black54
                            //         )
                            //       ),
                            //         child: Text("test"))
                            // //   ListView.builder(
                            // //       itemCount: viewModel.mytimelineList.length,
                            // //       itemBuilder: (context, index) {
                            // //         return TimelineListItem(viewModel.mytimelineList[index]);
                            // //     }
                            // // )
                            // )
                          ],
                        );
                      }
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
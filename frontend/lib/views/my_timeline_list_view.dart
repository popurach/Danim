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
                            Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: SearchBar()
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top:65),

                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        border:  Border.all(
                                          color: Colors.black54
                                        )
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: FlutterLogo()
                                          ),
                                          Expanded(
                                            flex: 1,
                                              child: VerticalDivider(color: Colors.black54)),
                                          Expanded(
                                            flex: 7,
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Container(
                                                    child: Text("text"),
                                                  ),
                                                  Container(
                                                    child: Text("text"),
                                                  ),
                                                  Container(
                                                    child: Text("text"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 15),
                                          decoration: BoxDecoration(
                                              border:  Border.all(
                                                  color: Colors.black54
                                              )
                                          ),
                                        )
                                    )
                                  ],
                                )
                            )
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
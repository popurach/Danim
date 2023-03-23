import 'package:flutter/material.dart';

import 'package:danim/view_models/search_bar_view_model.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBarViewModel>(
        builder: (context, viewModel, _) {
          return TextField(
            onChanged: (String? keyword) async {
              await viewModel.myTimelineSearch(keyword);
            },
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                        color: Colors.black54,
                        width: 3
                    )
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Colors.black54,
                      width: 3
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Colors.blueAccent,
                      width: 3
                  ),
                ),
                suffixIcon: IconButton(
                    icon: const Icon(
                        Icons.search
                        , color: Colors.blueAccent
                    ),
                    onPressed: () {
                      viewModel.myTimelineSearch(viewModel.searchKeyWord);
                    }
                )
                ,
                hintText: "검색..."
            ),
          );
        }
    );
  }
}
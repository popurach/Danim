import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

var dio = Dio();

class SearchBarViewModel extends ChangeNotifier {
  String? _searchKeyWord;
  String? get searchKeyWord => _searchKeyWord;
  set searchKeyWord (String? newString) {
    _searchKeyWord = newString;
  }

  List? _myTimelines;
  List? get myTimelines => _myTimelines;
  set myTimelines (List? newList) {
    _myTimelines = newList;
  }

  List? _posts;
  List? get posts => _posts;
  set posts (List? newPosts) {
    _posts = newPosts;
  }


  Future<void> myTimelineSearch(String? value) async {
    const timelineSearchUrl = "";

    if (value != null) {
      searchKeyWord = value;
      Response searchResponse = await dio.get(timelineSearchUrl);
      myTimelines = searchResponse.data[0];
    }
  }

  Future<void> postsSearch(String? value) async {
    const postSearchUrl = "";

    if (value != null) {
      searchKeyWord = value;
      Response searchResponse = await dio.get(postSearchUrl);
      posts = searchResponse.data[0];
    }
  }
}
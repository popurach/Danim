import 'package:danim/models/UserSearchResults.dart';
import 'package:danim/views/search_bar_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var dio = Dio();
var logger = Logger();

class SearchBarViewModel extends ChangeNotifier {
  final String searchUrl = "http://j8a701.p.ssafy.io:5000/api/auth/user";

  String? _searchKeyWord = "";
  String? get searchKeyWord => _searchKeyWord;
  set searchKeyWord (String? newString) {
    _searchKeyWord = newString;
  }

  List<UserSearchResult> _searchedResults = [];
  List<UserSearchResult> get searchedResults => _searchedResults;
  set searchedResults (List<UserSearchResult> newList) {
    _searchedResults = newList;
  }

  List? _posts;
  List? get posts => _posts;
  set posts (List? newPosts) {
    _posts = newPosts;
  }

  bool _isSearching = false;
  bool get isSearching => _isSearching;
  set isSearching (bool newBool) {
    _isSearching = newBool;
  }



  FocusNode _myfocus = FocusNode();
  FocusNode get myfocus => _myfocus;

  Future<void> searchUser(String? keyword) async {
    Response response = await dio.get(searchUrl);
    if (response.statusCode == 200) {
      logger.d(response.data);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // isSearching = false;
    // searchKeyWord = "";
    super.dispose();
  }
}
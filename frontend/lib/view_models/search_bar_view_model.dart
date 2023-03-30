import 'package:danim/models/UserSearchResults.dart';
import 'package:danim/utils/auth_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class SearchBarViewModel extends ChangeNotifier {

  final _dio = AuthDio().getDio();
  get dio => _dio;

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
    searchKeyWord = keyword;
    Response response = await _dio.get('api/auth/user');

    if (response.statusCode == 200) {
      logger.d(response.data);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // isSearching = false;
    // searchKeyWord = "";
    super.dispose();
  }
}
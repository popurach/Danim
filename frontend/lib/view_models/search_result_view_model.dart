import 'package:danim/services/search_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utils/auth_dio.dart';

class SearchResultViewModel extends ChangeNotifier {
  BuildContext _context;

  late String _keyword;
  String get keyword => _keyword;

  late List _searchedPosts;
  List get searchedPosts => _searchedPosts;

  SearchResultViewModel(this._context,this._keyword) {
    getPost(_context,_keyword);
    notifyListeners();
  }

  void getPost(BuildContext context, String searchKeyword) async {
    _searchedPosts = await SearchRepository().searchPosts(context, searchKeyword);
    notifyListeners();
  }

}
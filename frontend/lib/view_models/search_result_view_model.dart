import 'package:danim/services/search_repository.dart';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';



class SearchResultViewModel extends ChangeNotifier {
  final BuildContext _context;

  final String _keyword;
  String get keyword => _keyword;

  List _searchedPosts = [];
  List get searchedPosts => _searchedPosts;

  SearchResultViewModel(this._context,this._keyword) {
    getPost(_context,_keyword);
    notifyListeners();
  }

  void getPost(BuildContext context, String searchKeyword) async {
    _searchedPosts = await SearchRepository().searchPosts(context, searchKeyword);
    logger.d(_searchedPosts);
    notifyListeners();
  }

}
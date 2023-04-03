import 'package:danim/models/SearchedPost.dart';
import 'package:danim/services/search_repository.dart';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';



class SearchResultViewModel extends ChangeNotifier {
  final BuildContext _context;

  final String _keyword;
  String get keyword => _keyword;

  int? userUid;

  List<SearchedPost> _searchedPosts = [];
  List<SearchedPost> get searchedPosts => _searchedPosts;

  SearchResultViewModel(this._context,this._keyword, {this.userUid}) {
    getPost(_context,_keyword);
    notifyListeners();
  }

  void getPost(BuildContext context, String searchKeyword) async {
    if (userUid == null) {
      _searchedPosts = await SearchRepository().searchPosts(context, searchKeyword);
    } else {
      _searchedPosts = await SearchRepository().searchMyPosts(context, searchKeyword);
    }

    notifyListeners();
  }

}
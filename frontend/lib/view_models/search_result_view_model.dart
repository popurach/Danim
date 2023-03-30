import 'package:danim/services/search_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utils/auth_dio.dart';

class SearchResultViewModel extends ChangeNotifier {

  final _dio = AuthDio().getDio();
  get dio => _dio;

  late String _keyword;
  String get keyword => _keyword;

  late List _searchedPosts;
  List get searchedPosts => _searchedPosts;

  SearchResultViewModel(this._keyword) {
    getPost(_keyword);
    notifyListeners();
  }

  void getPost(String searchKeyword) async {
    _searchedPosts = await SearchRepository().searchPosts(searchKeyword);
    notifyListeners();
  }

}
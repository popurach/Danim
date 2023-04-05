import 'package:danim/services/search_repository.dart';
import 'package:flutter/material.dart';

import '../models/UserInfo.dart';

class SearchBarViewModel extends ChangeNotifier {
  bool isMyFeed;

  String? _searchKeyWord = "";

  String? get searchKeyWord => _searchKeyWord;

  set searchKeyWord(String? newString) {
    _searchKeyWord = newString;
    notifyListeners();
  }

  List<UserInfo> _searchedResults = [];

  List<UserInfo> get searchedResults => _searchedResults;

  set searchedResults(List<UserInfo> newList) {
    _searchedResults = newList;
    notifyListeners();
  }

  List? _posts;

  List? get posts => _posts;

  set posts(List? newPosts) {
    _posts = newPosts;
  }

  bool _isSearching = false;

  bool get isSearching => _isSearching;

  set isSearching(bool newBool) {
    _isSearching = newBool;
  }

  SearchBarViewModel({required this.isMyFeed});

  FocusNode _myfocus = FocusNode();

  FocusNode get myfocus => _myfocus;

  UnfocusDisposition disposition = UnfocusDisposition.scope;

  Future<void> searchUser(BuildContext context, String? keyword) async {
    _searchKeyWord = keyword;
    if (keyword != "") {
      if (!isMyFeed) {
        _searchedResults =
            await SearchRepository().searchToSearchBar(context, keyword!);
      }
    }
    notifyListeners();
  }

  void unFocus() {
    _myfocus.unfocus();
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

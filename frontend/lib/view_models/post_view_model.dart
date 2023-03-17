import 'package:cached_network_image/cached_network_image.dart';
import 'package:danim/models/Post.dart';
import 'package:flutter/cupertino.dart';

class PostViewModel with ChangeNotifier {
  int _currentPageIndex = 0;
  final Post _post;

  final cachedImagedList = <Widget>[];
  final controller = PageController(initialPage: 0);

  PostViewModel(this._post) {
    for (var imageUrl in post.imageUrls) {
      cachedImagedList.add(SizedBox(
        height: 500,
        child: CachedNetworkImage(imageUrl: imageUrl),
      ));
    }
  }

  int get currentPageIndex => _currentPageIndex;

  Post get post => _post;

  changeCurrentPageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  set currentPageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }
}

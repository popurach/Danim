import 'package:danim/services/post_repository.dart';
import 'package:flutter/cupertino.dart';

import '../models/Post.dart';

class PostViewModel extends ChangeNotifier {
  final Post _post;

  PostViewModel(this._post);

  Post get post => _post;

  changeIsFavorite(context) async {
    final res =
        await PostRepository().changeFavoritePost(context, _post.postId);
    _post.isFavorite = res['favorite'];
    _post.favoriteCount = res['totalFavorite'];
    notifyListeners();
  }
}

import 'package:danim/models/Post.dart';

class PostViewModel {
  final Post _post;

  PostViewModel(this._post);

  Post get post => _post;
}

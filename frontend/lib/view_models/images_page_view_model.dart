import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagesPageViewModel extends ChangeNotifier {
  final List<String> _imagesUrl;
  final cachedImagedList = <Widget>[];
  final controller = PageController(initialPage: 0);

  ImagesPageViewModel(this._imagesUrl) {
    for (var imageUrl in _imagesUrl) {
      cachedImagedList.add(CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ));
    }
  }
}

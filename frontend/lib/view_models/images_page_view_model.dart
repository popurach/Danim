import 'dart:io';

import 'package:camera/camera.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImagesPageViewModel extends ChangeNotifier {
  List<String>? imagesUrl;
  List<XFile>? xFileList;
  final imageList = <Widget>[];
  final controller = PageController(initialPage: 0);

  ImagesPageViewModel({this.imagesUrl, this.xFileList}) {
    if (imagesUrl != null && xFileList == null) {
      for (var imageUrl in imagesUrl!) {
        imageList.add(
          ExtendedImage.network(
            imageUrl,
            cache: true,
            fit: BoxFit.cover,
          ),
        );
      }
    } else if (imagesUrl == null && xFileList != null) {
      for (var xFile in xFileList!) {
        imageList.add(Image.file(
          File(xFile.path),
          fit: BoxFit.cover,
        ));
      }
    }
  }
}

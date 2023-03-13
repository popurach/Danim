import 'dart:io';

import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PictureView extends StatelessWidget {
  final List<XFile> images;

  const PictureView(this.images);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pictures'),
      ),
      // body: GridView.builder(
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 3,
      //     crossAxisSpacing: 4.0,
      //     mainAxisSpacing: 4.0,
      //   ),
      //   itemCount: images.length,
      //   itemBuilder: (context, index) {
      //     return Image.file(File(images[index].path));
      //   },
      // ),
      body: CarouselSlider(
        options: CarouselOptions(
        height: 400.0,
        enableInfiniteScroll: false,
          viewportFraction: 0.55,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
        items: images.map((file) {
          return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: 200,
                  margin: const EdgeInsets.all(4),
                  child: Image.file(
                    File(file.path),
                    fit: BoxFit.cover,
                  ),
                );
              }
          );
      }).toList()
     )
    );
  }
}
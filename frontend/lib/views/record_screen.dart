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
      body: Column(
        children: [
          // 캐러셀
          Container(
            height: MediaQuery.of(context).size.height * 0.60,
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.width * 1.20,
                enableInfiniteScroll: false,
                viewportFraction: 0.70,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: images.map((file) {
                return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        child: Image.file(
                          File(file.path),
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                  );
                }).toList()
              ),
          ),

          // 녹음 실행 관련 컨테이너
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      // playSound
                    },
                    icon: const Icon(Icons.play_arrow)
                ),

              ],
            )
          ),

          // 버튼 컨테이너
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),

                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.photo_outlined),
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 70,
                  height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.multitrack_audio, size: 45),
                    color: Colors.white,
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(right: 50),
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.upload, size:28),
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

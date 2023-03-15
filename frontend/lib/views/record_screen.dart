import 'dart:io';

import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


import '../view_models/record_view_model.dart';

class RecordView extends StatelessWidget {
  final List<XFile> images;

  const RecordView(this.images);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pictures'),
        ),
        body: Column (
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
                    child: ColoredContainer(
                      defaultColor: Colors.redAccent,
                      highlightColor: Colors.greenAccent,
                      onTapDown: () {
                        RecordViewModel().startRecording();
                      },
                      onTapUp: () {
                        RecordViewModel().stopRecording();
                      },
                      child: const Icon(
                        Icons.multitrack_audio,
                        color: Colors.white,
                        size:50,
                      ),
                    ),
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
          ]
        )
      ),
    );
  }
}

class ColoredContainer extends StatefulWidget {
  final Widget child;
  final Color defaultColor;
  final Color highlightColor;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;

  const ColoredContainer({
    Key? key,
    required this.child,
    required this.defaultColor,
    required this.highlightColor,
    this.onTapDown,
    this.onTapUp,
  }) : super(key: key);

  @override
  _ColoredContainerState createState() => _ColoredContainerState();
}

class _ColoredContainerState extends State<ColoredContainer> {
  Color _color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (widget.onTapDown != null) {
          widget.onTapDown!();
        }
        setState(() {
          _color = widget.highlightColor;
        });
      },
      onTapUp: (_) {
        if (widget.onTapUp != null) {
          widget.onTapUp!();
        }
        setState(() {
          _color = widget.defaultColor;
        });
      },
      onTapCancel: () {
        setState(() {
          _color = widget.defaultColor;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _color != Colors.transparent ? _color : widget.defaultColor,
        ),
        child: widget.child,
      ),
    );
  }
}
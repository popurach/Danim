import 'dart:io';


import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../view_models/record_view_model.dart';

class RecordView extends StatelessWidget {


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
              // 컨슈머로 변화 감지
              child: Consumer<RecordViewModel>(
                builder: (context, viewModel, child) {
                  return CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.width * 1.20,
                        enableInfiniteScroll: false,
                        viewportFraction: 0.70,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                      items: viewModel.imageList.map((file) {
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
                  );
                },

              ),
            ),

            // 녹음 실행 관련 컨테이너
            Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Consumer<RecordViewModel>(
                  builder: (context, viewModel, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 재생 버튼
                        IconButton(
                          onPressed: () {
                            // playSound
                            if (viewModel.isPlaying == false) {
                              viewModel.playRecordedFile();
                            } else {
                              viewModel.pauseRecordedFile();
                            }
                            },
                          icon: Icon(
                              viewModel.isPlaying?
                                  Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.black,
                                )
                        ),
                        // 프로그레스 바
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: viewModel.duration != Duration(seconds: 0) ? Slider(
                            value: viewModel.audioPositon.inSeconds.toDouble(),
                            max: viewModel.duration!.inSeconds.toDouble(),
                            onChanged: (value) {
                              final position = Duration(seconds: value.toInt());
                              viewModel.seekTo(position);
                              },
                          ) : Slider(
                              value: 0,
                              max: 0,
                              onChanged: (double value) {  },
                          ),
                        ),
                        viewModel.duration != Duration(seconds: 0) ?
                        viewModel.duration!.inSeconds.toInt() <= 9 ?
                        Text('00:0${viewModel.duration!.inSeconds.toInt()}')
                            : Text('00${viewModel.duration!.inSeconds.toInt()}')
                            : Text('00:00')
                      ],
                    );
                  }
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
                      onPressed: () {
                        if(Provider.of<RecordViewModel>(context, listen: false).imageList.length >= 9){
                          Provider.of<RecordViewModel>(context, listen: false).showAlert(context);
                        } else {
                          Provider.of<RecordViewModel>(context, listen: false).uploadFileFromGallery();
                        }
                      },
                      icon: const Icon(Icons.photo_outlined),
                      color: Colors.white,
                    ),
                  ),

                  // 녹음 버튼
                  Consumer<RecordViewModel>(
                    builder: (context, viewModel, child) {
                      return Container(
                        width: 70,
                        height: 70,
                        child: ColoredContainer(
                          defaultColor: Colors.redAccent,
                          highlightColor: Colors.greenAccent,
                          onTapDown: () {
                            viewModel.startRecording();
                          },
                          onTapUp: () {
                            viewModel.stopRecording();
                          },
                          child: const Icon(
                            Icons.multitrack_audio,
                            color: Colors.white,
                            size:50,
                          ),
                        ),
                      );
                    }

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

// 버튼을 클릭하고 있을 때에 색상이 바뀌는 컨테이너
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
    // GestureDetector로 감지
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
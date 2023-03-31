import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:danim/module/CupertinoAlertDialog.dart';
import 'package:danim/views/custom_app_bar.dart';
import 'package:danim/views/modify_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../module/audio_player_view.dart';
import '../module/audio_player_view_model.dart';
import '../view_models/record_view_model.dart';

class RecordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<RecordViewModel>(
        builder: (_, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(
              moveToModifyProfile: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ModifyProfile(),
                ),
              ),
              logout: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ModifyProfile(),
                ),
              ),
            ),
            body: Column(
              children: [
                // 캐러셀
                Container(
                    height: MediaQuery.of(context).size.height * 0.60,
                    // 컨슈머로 변화 감지
                    child: CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.width * 1.20,
                          enableInfiniteScroll: false,
                          viewportFraction: 0.70,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                        ),
                        items: viewModel.imageList.map((file) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              margin: const EdgeInsets.all(4),
                              child: Image.file(
                                File(file.path),
                                fit: BoxFit.cover,
                              ),
                            );
                          });
                        }).toList())),

                Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: viewModel.locationInfo.flag != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.memory(
                                        viewModel.locationInfo.flag!,
                                        fit: BoxFit.fitHeight),
                                  )
                                : Text("")),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 5,
                            child: Text(
                                '${viewModel.locationInfo.country} ${viewModel.locationInfo.address2}'))
                      ],
                    )),
                Container(
                    child: ChangeNotifierProvider<AudioPlayerViewModel>(
                  create: (_) => viewModel.audioPlayerViewModel,
                  child: AudioPlayerView(),
                )),

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
                            if (viewModel.imageList.length >= 9) {
                              OneButtonCupertinoAlertDiaglog().showFeedBack(
                                  context, "이미지는 \n최대 9장까지 \n등록 가능합니다.");
                            } else {
                              viewModel.uploadFileFromGallery();
                            }
                          },
                          icon: const Icon(Icons.photo_outlined),
                          color: Colors.white,
                        ),
                      ),

                      // 녹음 버튼
                      Container(
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
                            size: 50,
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
                          onPressed: () {
                            viewModel.uploadConfirm(context);
                          },
                          icon: const Icon(Icons.upload, size: 28),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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

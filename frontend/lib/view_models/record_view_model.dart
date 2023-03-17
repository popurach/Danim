import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:danim/view_models/camera_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import '../views/record_screen.dart';

var logger = Logger();

class RecordViewModel extends ChangeNotifier {
  late List<XFile> imageList;
  late String recordedFileName;
  late String recordedFilePath;
  late File recordedVoice;
  late bool playStarted = false;
  late bool isPlaying = false;
  late Future<Duration?> duration;
  late String test;

  RecordViewModel(this.imageList);

  AudioPlayer audioPlayer = AudioPlayer();

  final record = Record();
  String fileName = DateFormat('yyyyMMdd.Hmm.ss').format(DateTime.now());

  // 녹음 메서드
  Future<void> startRecording() async {
    final directory = Directory('/storage/emulated/0/Documents/records');
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    // 파일 저장 경로 지정
    final filePath = '${directory.path}/$fileName.m4a';
    // 레코딩 시작
    await record.start(
      path: filePath,
        encoder: AudioEncoder.aacLc,
      bitRate: 128000, // by default
      samplingRate: 44100
    );
    recordedFileName = fileName;
  }

  // 녹음 끝 파일 저장
  Future<void> stopRecording() async {
    await record.stop();
    final directory = Directory('/storage/emulated/0/Documents/records');

    recordedFilePath = '${directory.path}/$recordedFileName.m4a';
    await audioPlayer.setSourceUrl(recordedFilePath);
    duration = audioPlayer.getDuration();
    notifyListeners();
  }

  Future<void> playRecordedFile() async {
    await audioPlayer.play(DeviceFileSource(recordedFilePath));
    isPlaying = true;
    notifyListeners();

    audioPlayer.onPlayerComplete.listen((event) {
      isPlaying = false;
      notifyListeners();
    });
  }

  Future<void> pauseRecordedFile() async {
    audioPlayer.pause();
    isPlaying = false;
    notifyListeners();
  }

  Future<void> resumeRecordedFile() async {
    audioPlayer.resume();
    isPlaying = true;
    notifyListeners();
  }

  Future<void> stopRecordedFile() async {
    audioPlayer.stop();
    isPlaying = false;
    notifyListeners();
  }


  // 갤러리에서 파일 가져오기
  Future<void> uploadFileFromGallery() async {
    // 길이가 9 이상이면 작동하지 않음
    if (imageList.length >= 9) {
      return;
    }

    // multiple_images_picker 라이브러리 사용
    var images = await MultipleImagesPicker.pickImages(
      // 개수 제한
      maxImages: 9-imageList.length
    );
    // Asset들을 저장해서 경로를 만들고 xFile로 불러옴
    for (Asset image in images) {
      Directory externalDirectory = Directory('/storage/emulated/0/Documents/photos');
      ByteData byteData = await image.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      String? fileName = image.name;
      String tempPath = '${externalDirectory.path}/$fileName';
      await File(tempPath).writeAsBytes(imageData);
      XFile xFile = XFile(tempPath);
      imageList.add(xFile);
    }
    // 변했다고 알려줌
    notifyListeners();
  }

  // 9개 이상이면 경고창 띄움
  void showAlert(BuildContext context) {
    var alert = AlertDialog(
      content: const Text(
        "한 포스트에 등록 가능한 사진은 최대 9개 입니다.",
        style: TextStyle(fontSize: 50),
      ),
      actions: [
        FloatingActionButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            }
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

}
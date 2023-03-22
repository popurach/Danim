import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:intl/intl.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:dio/dio.dart';

import '../module/audio_player_view_model.dart';

class RecordViewModel extends ChangeNotifier {
  late List<XFile> _imageList;
  late Map _locationInfo;
  late String _recordedFileName;
  String _recordedFilePath = "";
  late AudioPlayerViewModel audioPlayerViewModel;

  Duration _duration = const Duration(seconds: 0);
  Duration _audioPosition = Duration.zero;

  List<XFile> get imageList => _imageList;

  Map get locationInfo => _locationInfo;
  set locationInfo (Map newInfo) {
    _locationInfo = newInfo;
  }

  void updateLocationInformation(Map<String, dynamic> locationInfo) {
    _locationInfo = locationInfo;
    notifyListeners();
  }


  String get recordedFileName => _recordedFileName;

  set recordedFileName(String newName) {
    _recordedFileName = newName;
  }

  String get recordedFilePath => _recordedFilePath;

  set recordedFilePath(String newPath) {
    _recordedFilePath = newPath;
  }

  Duration get duration => _duration;

  set duration(Duration newDuration) {
    _duration = newDuration;
  }

  Duration get audioPosition => _audioPosition;

  RecordViewModel(this._imageList, this._locationInfo) {
    audioPlayerViewModel = AudioPlayerViewModel(_recordedFilePath);
  }

  AudioPlayer audioPlayer = AudioPlayer();

  final record = Record();
  String fileName = DateFormat('yyyyMMdd.Hmm.ss').format(DateTime.now());

  // 사진 위치 정보 받아오는 메서드


  // 녹음 메서드
  Future<void> startRecording() async {
    final directory = Directory('/storage/emulated/0/Documents/records');
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    // 파일 저장 경로 지정
    if (recordedFilePath != "") {
      recordedFilePath = "";
    }
    final filePath = '${directory.path}/$fileName.m4a';
    // 레코딩 시작
    await record.start(
        path: filePath,
        encoder: AudioEncoder.aacLc,
        bitRate: 128000, // by default
        samplingRate: 44100);
    recordedFileName = fileName;
  }

  // 녹음 끝 파일 저장
  Future<void> stopRecording() async {
    await record.stop();
    final directory = Directory('/storage/emulated/0/Documents/records');

    recordedFilePath = '${directory.path}/$recordedFileName.m4a';
    await audioPlayer.setSourceUrl(recordedFilePath);
    duration = (await audioPlayer.getDuration())!;
    audioPlayerViewModel.audioFilePath = recordedFilePath;
    notifyListeners();
  }

  // 갤러리에서 파일 가져오기
  Future<void> uploadFileFromGallery() async {
    // 길이가 9 이상이면 작동하지 않음
    if (imageList.length >= 9) {
      return;
    }

    // multiple_images_picker 라이브러리 사용
    final images = await MultipleImagesPicker.pickImages(
        // 개수 제한
        maxImages: 9 - imageList.length);
    // Asset들을 저장해서 경로를 만들고 xFile로 불러옴
    for (Asset image in images) {
      Directory externalDirectory =
          Directory('/storage/emulated/0/Documents/photos');
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

  // 파일을 서버로 업로드하기
  Future<void> postFiles(BuildContext context) async {
    final dio = Dio();
    final List<MultipartFile> imageFiles =
        imageList.map((el) => MultipartFile.fromFileSync(el.path)).toList();
    final audioFile = await MultipartFile.fromFile(recordedFilePath);

    FormData formData = FormData.fromMap({
      'images': imageFiles,
      'audio': audioFile,
    });

    Response response = await dio.post("path", data: formData);

    if (response.statusCode == 200) {}
  }

  void uploadConfirm(BuildContext context) {
    final alert = CupertinoAlertDialog(
      content: const Text(
        "포스트를 \n등록할까요?",
        style: TextStyle(fontSize: 30),
      ),
      actions: [
        CupertinoDialogAction(
            child: const Text("참"),
            onPressed: () {
              postFiles(context);
              Navigator.of(context).pop();
            }),
        CupertinoDialogAction(
            child: const Text("거짓"),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

}

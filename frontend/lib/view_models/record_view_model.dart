import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:danim/models/LocationInformation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:record/record.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

import '../module/audio_player_view_model.dart';
import 'camera_view_model.dart';

var logger = Logger();

class RecordViewModel extends ChangeNotifier {
  late List<XFile> _imageList;

  LocationInformation _locationInfo =
      LocationInformation("", "", "", "", [] as Uint8List);

  LocationInformation get locationInfo => _locationInfo;

  set locationInfo(LocationInformation newInfo) {
    _locationInfo = newInfo;
    notifyListeners();
  }

  bool _haveLocation = false;

  late String _recordedFileName;
  String _recordedFilePath = "";
  late AudioPlayerViewModel audioPlayerViewModel;

  Duration _duration = const Duration(seconds: 0);
  Duration _audioPosition = Duration.zero;

  List<XFile> get imageList => _imageList;

  bool _isFirstPhotoFromGallery = false;

  bool get isFirstPhotoFromGallery => _isFirstPhotoFromGallery;

  set isFirstPhotoFromGallery(bool newBool) {
    _isFirstPhotoFromGallery = newBool;
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

  RecordViewModel(this._imageList) {
    getLocation();
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

    if (imageList.isEmpty) {
      isFirstPhotoFromGallery = true;
    }

    // multi_image_picker_viewr 라이브러리 사용
    final pickerController =
        MultiImagePickerController(maxImages: 9 - imageList.length, images: []);
    Directory externalDirectory =
        Directory('/storage/emulated/0/Documents/photos');
    await pickerController.pickImages();
    // 파일들을 저장해서 경로를 만들고 xFile로 불러옴
    for (final image in pickerController.images) {
      if (image.hasPath) {
        var imageFile = File(image.path!);
        Uint8List imageUint8 = await imageFile.readAsBytes();
        List<int> imageData = imageUint8.toList();
        String? fileName = image.name;
        String tempPath = '${externalDirectory.path}/$fileName';
        await File(tempPath).writeAsBytes(imageData);
        XFile xFile = XFile(tempPath);
        imageList.add(xFile);
      }
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

  void getLocation() async {
    if (_haveLocation == false) {
      if (imageList.isNotEmpty) {
        if (isFirstPhotoFromGallery == false) {
          _haveLocation = true;
          final currentPosition = await Geolocator.getCurrentPosition();
          final curLong = currentPosition.longitude;
          final curLat = currentPosition.latitude;
          final url =
              'https://api.geoapify.com/v1/geocode/reverse?lat=${curLat}&lon=${curLong}&apiKey=${apikey}&lang=ko&format=json';
          Response response = await dio.get(url);
          if (response.statusCode == 200) {
            LocationInformation newLocation = LocationInformation(
                response.data["results"][0]["country"],
                response.data["results"][0]["city"],
                response.data["results"][0]["district"],
                response.data["results"][0]["suburb"],
                [] as Uint8List);
            String countryCode = response.data["results"][0]["country_code"];
            final flagUrl = 'https://flagcdn.com/h240/$countryCode.png';
            Response<Uint8List> flagResponse = await dio.get(flagUrl,
                options: Options(responseType: ResponseType.bytes));
            newLocation.flag = flagResponse.data!;
            locationInfo = newLocation;
            notifyListeners();
          }
        }
      }
    }
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

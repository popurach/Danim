import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:danim/models/LocationInformation.dart';
import 'package:danim/models/PostForUpload.dart';
import 'package:danim/module/CupertinoAlertDialog.dart';
import 'package:danim/services/upload_repository.dart';
import 'package:danim/view_models/app_view_model.dart';
import 'package:danim/view_models/timeline_list_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../module/audio_player_view_model.dart';
import '../views/user_timeline_list_view.dart';
import 'camera_view_model.dart';

var logger = Logger();

class RecordViewModel extends ChangeNotifier {
  late List<XFile> _imageList;

  LocationInformation _locationInfo = LocationInformation(
      country: "", address2: "", address3: "", address4: "", flag: null);

  LocationInformation get locationInfo => _locationInfo;

  int _countryIndex = 0;
  int _postCodeIndex = 0;

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
    final filePath = '${directory.path}/$fileName.wav';
    // 레코딩 시작
    await record.start(path: filePath, encoder: AudioEncoder.wav);
    recordedFileName = fileName;
  }

  // 녹음 끝 파일 저장
  Future<void> stopRecording() async {
    await record.stop();
    final directory = Directory('/storage/emulated/0/Documents/records');

    recordedFilePath = '${directory.path}/$recordedFileName.wav';
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
  Future<void> postFiles(BuildContext context, UserInfo userInfo) async {
    final flag = MultipartFile.fromBytes(locationInfo.flag!,
        filename: locationInfo.country, contentType: MediaType('image', 'jpk'));
    final List<MultipartFile> imageFiles = imageList
        .map((el) => MultipartFile.fromFileSync(el.path,
            filename: el.name, contentType: MediaType('image', 'jpk')))
        .toList();
    final audioFile = await MultipartFile.fromFile(recordedFilePath,
        filename: "$recordedFileName.wav",
        contentType: MediaType('audio', 'wav'));

    FormData formData = FormData.fromMap({
      'flagFile': flag,
      'imageFiles': imageFiles,
      'voiceFile': audioFile,
      'timelineId': userInfo.travelingId,
      'address1': locationInfo.country,
      'address2': locationInfo.address2,
      'address3': locationInfo.address3,
      'address4': locationInfo.address4
    });
    Response response = await UploadRepository().uploadToServer(context, formData);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<TimelineListViewModel>(
                create: (_) => TimelineListViewModel(
                    context: context,
                    myUid: userInfo.userUid),
                child: UserTimeLineListView(),
              )),
              (route) => false).then((value) {
        Navigator.pushNamed(
            context,
            '/timeline/detail/${userInfo.travelingId}'
        );
      });
  }

  // 위치를 받아오는 함수
  void getLocation() async {
    if (_haveLocation == false) {
      if (imageList.isNotEmpty) {
        if (isFirstPhotoFromGallery == false) {
          _haveLocation = true;
          final currentPosition = await Geolocator.getCurrentPosition();
          final curLong = currentPosition.longitude;
          final curLat = currentPosition.latitude;
          final plainDio = Dio();
          final url =
              'https://api.geoapify.com/v1/geocode/reverse?lat=$curLat&lon=$curLong&apiKey=$apikey&lang=ko&type=street&format=json';
          Response response = await plainDio.get(url);
          if (response.statusCode == 200) {
            if (response.data["results"] != null) {
              List keyList = await response.data["results"][0].keys.toList();
              // 날
              _countryIndex = keyList.indexOf("country");
              _postCodeIndex = keyList.indexOf("postcode");
              // country 포함 6개 불러옴
              // 위치에 따라 응답이 조금씩 다르게 옴
              List valueList = await response.data["results"][0].values
                  .toList()
                  .sublist(_countryIndex, _countryIndex + 6);
              // 우편 번호 삭제
              valueList.removeAt(_postCodeIndex - _countryIndex);
              String countryName = valueList[0];
              String address2Name = valueList[2];
              String address3Name = valueList[3];
              String address4Name;
              if (keyList[4] == "postcode") {
                address4Name = valueList[5];
              } else {
                address4Name = valueList[4];
              }
              if (address3Name == address4Name) {
                address4Name = "";
              }
              String countryCode = valueList[1];
              final flagUrl = 'https://flagcdn.com/h240/$countryCode.png';
              Response<Uint8List> flagResponse = await plainDio.get(flagUrl,
                  options: Options(responseType: ResponseType.bytes));
              Uint8List? flagData = flagResponse.data;
              LocationInformation newLocation = LocationInformation(
                  country: countryName,
                  address2: address2Name,
                  address3: address3Name,
                  address4: address4Name,
                  flag: flagData);
              locationInfo = newLocation;
              notifyListeners();
            }
          }
        }
      }
    }
  }

  void uploadConfirm(BuildContext context, UserInfo userInfo) {
    final alert = CupertinoAlertDialog(
      content: const Text(
        "포스트를 \n등록할까요?",
        style: TextStyle(fontSize: 30),
      ),
      actions: [
        CupertinoDialogAction(
            child: const Text("참"),
            onPressed: () {
              postFiles(context, userInfo);
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

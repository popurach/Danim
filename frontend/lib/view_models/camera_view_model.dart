import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:danim/models/PostForUpload.dart';
import 'package:danim/view_models/record_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:logger/logger.dart';

var apikey = "fcc989ff906649ea961871b106cfc061";
var dio = Dio();
var logger = Logger();

class CameraViewModel extends ChangeNotifier {
  List<CameraDescription> _cameras = [];
  late CameraController _controller;
  late String _imagePath;
  late RecordViewModel recordViewModel;

  Map<dynamic, dynamic> _locationInformation = {
    "country":"",
    "city":"",
    "district":"",
    "suburb":"",
    "flagBytes": null
  };

  List<XFile> _allFileList = [];

  List<XFile> get allFileList => _allFileList;

  CameraController get controller => _controller;

  List<CameraDescription> get cameras => _cameras;

  String get imagePath => _imagePath;

  Map get locationInformation => _locationInformation;

  CameraViewModel() {
    recordViewModel = RecordViewModel(allFileList);
  }

  Future<void> initializeCamera() async {
    await Permission.camera.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    await Permission.location.request();

    final cameras = await availableCameras();
    _cameras = cameras;
    if (_cameras.isNotEmpty) {
      _controller = CameraController(_cameras.first, ResolutionPreset.high,);
      await _controller.initialize();
      _controller.setFlashMode(FlashMode.off);
      notifyListeners();
    }
  }

  Future<void> takePhoto() async {
    XFile file = await _controller.takePicture();
    if (allFileList.length < 9 ) {
      allFileList.add(file);

      // 파일 저장할 위치 지정
      Directory externalDirectory =
      Directory('/storage/emulated/0/Documents/photos');
      if (!await externalDirectory.exists()) {
        await externalDirectory.create(recursive: true);
      }

      final List<int> imageBytes = await file.readAsBytes();

      String dir = externalDirectory.path;
      final savePath = "$dir/${file.name}";

      // 파일 생성
      final File imageFile = File(savePath);

      // 파일에 이미지 저장
      await imageFile.writeAsBytes(imageBytes);


      // 파일의 exif 데이터 불러와서 작성하기
      // final exif = await Exif.fromPath(file.path);
      // await exif.writeAttributes({
      //   'GPSLatitude': currentPosition.latitude,
      //   'GPSLatitudeRef': 'N',
      //   'GPSLongitude': currentPosition.longitude,
      //   'GPSLongitudeRef': 'W',
      // });
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

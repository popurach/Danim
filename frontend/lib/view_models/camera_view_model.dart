import 'dart:async';
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
import 'package:device_info_plus/device_info_plus.dart';

import 'package:logger/logger.dart';

var apikey = "fcc989ff906649ea961871b106cfc061";
var logger = Logger();
final deviceInfoPlugin = DeviceInfoPlugin();

class CameraViewModel extends ChangeNotifier {
  List<CameraDescription> _cameras = [];
  late CameraController _controller;
  late String _imagePath;
  late RecordViewModel recordViewModel;

  bool _isTaking = false;
  bool get isTaking => _isTaking;

  double? _previewWidth;
  double? get previewWidth => _previewWidth;

  double? _currentWidth;
  double? get currentWidth => _currentWidth;

  double? _previewHeight;
  double? get previewHeight => _previewHeight;

  double? _currentHeight;
  double? get currentHeight => _currentHeight;

  double? _aspectRatio;
  double? get aspectRatio => _aspectRatio;




  List<XFile> _allFileList = [];

  List<XFile> get allFileList => _allFileList;

  CameraController get controller => _controller;

  List<CameraDescription> get cameras => _cameras;

  String get imagePath => _imagePath;



  CameraViewModel() {
    recordViewModel = RecordViewModel(allFileList);
  }

  Future<void> initializeCamera() async {
    AndroidDeviceInfo deviceInfo = await deviceInfoPlugin.androidInfo;
    final sdkInfo = deviceInfo.version.sdkInt;
    if (sdkInfo >= 33) {
      await Permission.camera.request();
      await Permission.photos.request();
      await Permission.videos.request();
      await Permission.audio.request();
      await Permission.manageExternalStorage.request();
      await Permission.location.request();
    } else {
      await Permission.camera.request();
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
      await Permission.location.request();
    }


    final cameras = await availableCameras();
    _cameras = cameras;
    if (_cameras.isNotEmpty) {
      _controller = CameraController(_cameras.first, ResolutionPreset.high,);
      await _controller.initialize();
      _controller.setFlashMode(FlashMode.off);
      _previewHeight = _controller.value.previewSize?.height;
      _previewWidth = _controller.value.previewSize?.width;
      _aspectRatio = _previewHeight! / _previewWidth!;
      _currentHeight = _previewHeight;
      _currentWidth = _currentHeight! * _aspectRatio!;
      notifyListeners();
    }
  }

  Future<void> takePhoto() async {

    if (allFileList.length < 9 ) {
      if (_isTaking == false) {
        _isTaking = true;
        updateHeightAndWidth(_previewHeight!*0.9);
        notifyListeners();
        XFile file = await _controller.takePicture();
        await Future.delayed(const Duration(milliseconds: 100));
        _isTaking = false;
        updateHeightAndWidth(_previewHeight!);
        notifyListeners();
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
      }
    }
    notifyListeners(); // Add this line
  }

  void updateHeightAndWidth(double height) {
    _currentHeight = height;
    _currentWidth = height * _aspectRatio!;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

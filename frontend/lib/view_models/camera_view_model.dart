import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:native_exif/native_exif.dart';
import 'package:intl/intl.dart';


class CameraViewModel extends ChangeNotifier {

  List<CameraDescription> _cameras = [];
  late CameraController _controller;
  late String _imagePath;


  List<XFile> allFileList = [];

  Future<void> initializeCamera() async {
    await Permission.camera.request();
    await Permission.storage.request();

    var cameras = await availableCameras();
    _cameras = cameras;
    if (_cameras.isNotEmpty) {
      _controller = CameraController(_cameras.first, ResolutionPreset.high);
      await _controller.initialize();
      notifyListeners();
    }
  }

  Future<void> takePhoto() async {

      XFile file = await _controller.takePicture();

      if (allFileList.length < 9) {
        allFileList.add(file);
        // 현재 위치 불러오기
        // final currentPosition = await Geolocator.getCurrentPosition();

        // 사진의 EXIF 메타 데이터에 정보 저장

        // final exif = await Exif.fromPath(file.path);
        //
        // final dateFormat = DateFormat('yyyy:MM:dd HH:mm:ss');
        // await exif.writeAttribute('DateTimeOriginal', dateFormat.format(DateTime.now()));
        // await exif.writeAttribute('GPSLatitude', currentPosition.latitude);
        // await exif.writeAttribute('GPSLongitude', currentPosition.longitude);


        Uint8List bytes = await file.readAsBytes();

        await ImageGallerySaver.saveImage(
            bytes,
            quality: 100,
            name: file.name,
        );
      }

      notifyListeners();
  }

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

  CameraController get controller => _controller;
  List<CameraDescription> get cameras => _cameras;
  String get imagePath => _imagePath;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}





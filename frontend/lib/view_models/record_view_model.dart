import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:danim/view_models/camera_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import '../views/record_screen.dart';


class RecordViewModel extends ChangeNotifier {
  late final List<XFile> imageList;

  RecordViewModel(this.imageList);

  final record = Record();
  String fileName = DateFormat('yyyyMMdd.Hmm.ss').format(DateTime.now());

  Future<void> startRecording() async {
    final directory = Directory('/storage/emulated/0/Documents/records');
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    final filePath = '${directory.path}/$fileName.m4a';
    await record.start(
      path: filePath,
        encoder: AudioEncoder.aacLc,
      bitRate: 128000, // by default
      samplingRate: 44100
    );


  }

  Future<void> stopRecording() async {
    await record.stop();
  }

  Future<void> uploadFileFromGallery() async {
    if (imageList.length >= 9) {

    }
    var images = await MultipleImagesPicker.pickImages(
      maxImages: 9-imageList.length
    );
    for (Asset image in images) {
      ByteData byteData = await image.getByteData();
      var imageData = byteData.buffer.asUint8List();
      XFile xFile = XFile.fromData(imageData);
      imageList.add(xFile);
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

}
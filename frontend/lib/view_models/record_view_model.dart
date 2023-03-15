import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:record/record.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class RecordViewModel extends ChangeNotifier {

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

}
import 'package:danim/models/Timeline.dart';
import 'package:danim/utils/auth_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class UploadRepository {
  UploadRepository._internal();

  static final UploadRepository _instance = UploadRepository._internal();

  factory UploadRepository() => _instance;


  // 메인피드 타임라인 리스트 가져오기
  Future<dynamic> uploadToServer(BuildContext context, FormData formData) async {
    try {
      final dio = await authDio(context);
      Response response = await dio.post("api/auth/post", data: formData);
      if (response.statusCode == 200) {
        return response.data["timelineId"];
      } else {
        return -1;
      }
    } on DioError catch (error) {
      throw Exception('Fail to upload to Server: ${error.message}');
    }
  }
}

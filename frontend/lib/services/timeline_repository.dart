import 'package:danim/models/Timeline.dart';
import 'package:danim/utils/auth_dio.dart';
import 'package:dio/dio.dart';

class TimelineRepository {
  TimelineRepository._internal();

  static final TimelineRepository _instance = TimelineRepository._internal();

  factory TimelineRepository() => _instance;

  final _dio = AuthDio().getDio();

  // 메인피드 타임라인 리스트 가져오기
  Future<List<Timeline>> getMainTimelineByPageNum(int pageNum) async {
    try {
      Response response = await _dio.get('api/auth/timeline/main/$pageNum');
      return List.from(response.data.map((json) => Timeline.fromJson(json)));
    } on DioError catch (error) {
      throw Exception('Fail to get timeline: ${error.message}');
    }
  }
}

import 'package:danim/models/Timeline.dart';
import 'package:danim/models/TimelineDetail.dart';
import 'package:danim/utils/auth_dio.dart';
import 'package:danim/view_models/app_view_model.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../models/TimelineInfo.dart';

class TimelineRepository {
  TimelineRepository._internal();

  static final TimelineRepository _instance = TimelineRepository._internal();

  factory TimelineRepository() => _instance;

  // 메인피드 타임라인 리스트 가져오기
  Future<List<Timeline>> getMainTimelineByPageNum(context, int pageNum) async {
    try {
      final dio = await authDio(context);
      Response response = await dio.get('api/auth/timeline/main/$pageNum');
      return List.from(response.data.map((json) => Timeline.fromJson(json)));
    } on DioError catch (error) {
      throw Exception('Fail to get timeline: $error');
    }
  }

  Future<List<Timeline>> getUserTimelineByPageNum(context, int pageNum, userUid) async {
    // 앱뷰모델에서 현재 기기에서 로그인한 유저 uid를 가져오기 위해서 선언
    final appViewModel = Provider.of<AppViewModel>(context);
    final dio = await authDio(context);
    try {
      // 페이지 유저 Uid == 로그인한 유저 Uid면 로그인한 유저 타임라인 리스트를 불러옴
      if ( userUid == appViewModel.userUid ) {
        Response response = await dio.get('api/auth/timeline/mine/$pageNum');
        if (response.statusCode == 400) {
          return [];
        } else {
          return List.from(response.data.map((json) => Timeline.fromJson(json)));
        }
      } else {
        // 아니면 해당하는 유저 uid에 해당하는 타임라인 리스트를 불러옴
        Response response = await dio.get('api/auth/timeline/other/$userUid/$pageNum');
        return List.from(response.data.map((json) => Timeline.fromJson(json)));
      }
    } on DioError catch (error) {
      throw Exception('Fail to get timeline: $error');
    }
  }

  Future<TimelineInfo> getTimelineDetailsByTimelineId(
      context, int timelineId) async {
    try {
      final dio = await authDio(context);
      Response response = await dio.get('api/auth/timeline/$timelineId');
      return TimelineInfo.fromJson(response.data);
    } catch (error) {
      throw Exception('Fail to get timeline: $error');
    }
  }
}

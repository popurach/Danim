import 'package:danim/models/Timeline.dart';
import 'package:danim/models/TimelineDetail.dart';
import 'package:danim/utils/auth_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../models/TimelineInfo.dart';
import '../view_models/app_view_model.dart';

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

  Future<List<Timeline>> getMyTimelineByPageNum(context, int pageNum) async {
    // 앱뷰모델에서 현재 기기에서 로그인한 유저 uid를 가져오기 위해서 선언
    final appViewModel = Provider.of<AppViewModel>(context);
    final dio = await authDio(context);
    try {
        Response response = await dio.get('api/auth/timeline/mine/$pageNum');
        return List.from(response.data.map((json) => Timeline.fromJson(json)));
    } on DioError catch (error) {
      throw Exception('Fail to get timeline: $error');
    }
  }

  Future<List<Timeline>> getOtherTimelineByPageNum(context, int pageNum, userUid) async {
    // 앱뷰모델에서 현재 기기에서 로그인한 유저 uid를 가져오기 위해서 선언
    final dio = await authDio(context);
    try {
      Response response = await dio.get('api/auth/timeline/other/$userUid/$pageNum');
      return List.from(response.data.map((json) => Timeline.fromJson(json)));
    } on DioError catch (error) {
      throw Exception('Fail to get timeline: $error');
    }
  }

  // 타임라인 아이디로 타임라인 한개 정보 가져오기
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

  // 타임라인 공개 비공개 전환
  Future<bool> changeTimelinePublic(
      BuildContext context, int timelineId) async {
    try {
      final dio = await authDio(context);
      Response response =
          await dio.put('/api/auth/timeline/switch/$timelineId');
      return response.data;
    } catch (e) {
      throw Exception('Fail to change timeline public: $e');
    }
  }

  // 여행 종료
  Future<void> endTravel(context, int timelineId, String title) async {
    try {
      final dio = await authDio(context);
      Response response =
          await dio.put('/api/auth/timeline/$timelineId/$title');
    } catch (e) {
      throw Exception('Fail to end travel $e');
    }
  }
}

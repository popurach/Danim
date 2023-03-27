import 'package:danim/models/Timeline.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../models/dto/Token.dart';

class UserRepository {
  // 싱글턴 패턴
  UserRepository._internal();
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;

  final _dio = Dio(BaseOptions(baseUrl: 'http://j8a701.p.ssafy.io:5000/'));

  // 메인화면의 타임리스트를 가져오는 함수 Future은 js의 Promise라고 보시면 됩니다.
  Future<List<Timeline>> getMainTimeline() async {
    try {
      Response response = await _dio.get('api/auth/timeline/main');
      return List.from(response.data.map((json) => Timeline.fromJson(json)));
    } catch (error) {
      throw Exception('Fail to get timeline: $error');
    }
  }

  Future<Timeline> getTimelineById(int id) async {
    try {
      Response response = await _dio.get('api/auth/timeline/$id');
      return Timeline.fromJson(response.data);
    } catch (error) {
      throw Exception('Fail to get timeline id $id : $error');
    }
  }

  Future<Token> kakaoLogin(Token token) async {
    try {
      Response response =
          await _dio.post('/api/login/kakao', data: token.toJson());
      return Token.fromJson(response.data);
    } catch (error) {
      throw Exception('Fail to login: $error');
    }
  }

  Future<String> getUserProfileImageUrl(Token token) async {
    try {
      Response response = await _dio.get('api/auth/user/info',
          options: Options(
              headers: {'Authorization': 'Bearer ${token.accessToken}'}));
      final String profileImageUrl = response.data['profileImageUrl'];
      return profileImageUrl;
    } catch (error) {
      throw Exception('Fail to login: $error');
    }
  }
}

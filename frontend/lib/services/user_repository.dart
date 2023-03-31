import 'package:danim/models/Timeline.dart';
import 'package:danim/models/UserInfo.dart';
import 'package:danim/utils/auth_dio.dart';
import 'package:dio/dio.dart';

import '../models/Token.dart';

class UserRepository {
  // 싱글턴 패턴
  UserRepository._internal();

  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() => _instance;

  final _dio = Dio(BaseOptions(baseUrl: 'http://j8a701.p.ssafy.io:5000/'));

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

  Future<UserInfo> getUserInfo(context) async {
    try {
      final dio = await authDio(context);
      Response response = await dio.get('api/auth/user/info');
      final UserInfo userInfo = UserInfo.fromJson(response.data);
      return userInfo;
    } catch (error) {
      throw Exception('Fail to login: $error');
    }
  }
}

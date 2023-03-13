import 'package:danim/models/Timeline.dart';
import 'package:dio/dio.dart';

class UserRepository {
  // 싱글턴 패턴
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;
  UserRepository._internal();
  // json파싱이나. multipart파일 전송을 원활히 하기 위해 Dio 라이브러리 사용
  // baseurl 설정
  final _dio = Dio(BaseOptions(baseUrl: 'https://Danim.com/'));
  // 메인화면의 타임리스트를 가져오는 함수 Future은 js의 Promise라고 보시면 됩니다.
  Future<List<Timeline>> getMainTimeline() async {
    try {
      Response response = await _dio.get('api/auth/timeline/main');
      return List.from(response.data.map((json) => Timeline.fromJson(json)));
    } catch (error) {
      throw Exception('Fail to get timeline: $error');
    }
  }
}

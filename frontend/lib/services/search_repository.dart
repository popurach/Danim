import 'package:danim/models/Timeline.dart';
import 'package:danim/utils/auth_dio.dart';
import 'package:dio/dio.dart';

class SearchRepository {
  SearchRepository._internal();

  static final SearchRepository _instance = SearchRepository._internal();

  factory SearchRepository() => _instance;

  final _dio = AuthDio().getDio();

  Future<dynamic> searchToSearchBar(String keyword) async {
    try {
      Response response = await _dio.get("api/auth/user?search=$keyword");
      return response.data;
    } on DioError catch (error) {
      throw Exception('Fail to get search Results: ${error.message}');
    }
  }

  // 메인피드 타임라인 리스트 가져오기
}

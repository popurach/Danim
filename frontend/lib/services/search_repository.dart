import 'package:danim/models/Timeline.dart';
import 'package:danim/utils/auth_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class SearchRepository {
  SearchRepository._internal();

  static final SearchRepository _instance = SearchRepository._internal();

  factory SearchRepository() => _instance;

  // 검색창에 검색했을 때 유저를 가져옴
  Future<dynamic> searchToSearchBar(BuildContext context, String keyword) async {
    try {
      final dio = await authDio(context);
      Response response = await dio.get("api/auth/user?search=$keyword");
      return response.data;
    } on DioError catch (error) {
      throw Exception('Fail to get search Results: ${error.message}');
    }
  }

  // 검색 화면에 진입했을 때 포스트들을 요청함
  Future<dynamic> searchPosts(BuildContext context, String keyword) async {
    try {
      final dio = await authDio(context);
      Response response = await dio.get('/api/auth/post/$keyword');
      return response.data;
    } on DioError catch (error) {
      throw Exception('Fail to get search Posts: ${error.message}');
    }
  }
}

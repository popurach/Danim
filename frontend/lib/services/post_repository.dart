import 'package:danim/utils/auth_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PostRepository {
  PostRepository._internal();

  static final PostRepository _instance = PostRepository._internal();

  factory PostRepository() => _instance;

  Future<Map<String, dynamic>> changeFavoritePost(
      BuildContext context, int postId) async {
    try {
      final dio = await authDio(context);
      const storage = FlutterSecureStorage();
      final String? userUid = await storage.read(key: 'userUid');
      Response response = await dio
          .post('api/auth/like', data: {'userUid': userUid, 'postId': postId});
      return response.data;
    } catch (e) {
      throw Exception('ChangeFavoritePost Error $e');
    }
  }
}

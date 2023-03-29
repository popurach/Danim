import 'package:danim/views/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

var logger = Logger();

Future<Dio> authDio(BuildContext context) async {
  final dio = Dio(BaseOptions(baseUrl: 'http://j8a701.p.ssafy.io:5000/'));

  const storage = FlutterSecureStorage();

  dio.interceptors.clear();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await storage.read(key: 'accessToken');
        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      },
      onError: (error, handler) async {
        try {
          final refreshToken = await storage.read(key: 'refreshToken');
          final userUid = await storage.read(key: 'userUid');

          logger.d(error.response);

          // accessToken 만료 됐을 때
          if (error.response?.statusCode == 401) {
            final refreshDio =
                Dio(BaseOptions(baseUrl: 'http://j8a701.p.ssafy.io:5000/'));
            Response response = await refreshDio.post(
              'api/login/reissuance',
              options:
                  Options(headers: {'refreshToken': 'Bearer $refreshToken'}),
              data: {'userUid': userUid},
            );
            if (response.statusCode! < 400) {
              final String newAccessToken =
                  (response.headers['Authorization'] as String).split(' ')[1];
              storage.write(key: 'accessToken', value: newAccessToken);
              final clonedRequest = await dio.request(error.requestOptions.path,
                  options: Options(
                      method: error.requestOptions.method,
                      headers: {'Authorization': 'Bearer $newAccessToken'}),
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters);
              return handler.resolve(clonedRequest);
            } else {
              if (context.mounted) {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginPage(),
                  ),
                );
              }
            }
            return handler.next(error);
          }
        } catch (e) {
          throw Exception('refreshError: $e');
        }
      },
    ),
  );
  return dio;
}

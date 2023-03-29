import 'package:danim/views/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
        final refreshToken = await storage.read(key: 'refreshToken');
        final userUid = await storage.read(key: 'userUid');

        // accessToken 만료 됐을 때
        if (error.response?.statusCode == 403) {
          Response response = await dio.post(
            'api/login/reissuance',
            options: Options(headers: {'refreshToken': 'Bearer $refreshToken'}),
            data: {'userUid': userUid},
          );
          if (response.statusCode! < 400) {
            final clonedRequest = await dio.request(error.requestOptions.path,
                options: Options(
                    method: error.requestOptions.method,
                    headers: error.requestOptions.headers),
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
      },
    ),
  );
  return dio;
}

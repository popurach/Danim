import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthDio {
  static final AuthDio _singleton = AuthDio._internal();

  late Dio _dio;

  factory AuthDio() {
    return _singleton;
  }

  AuthDio._internal() {
    _dio = Dio(BaseOptions(baseUrl: 'http://j8a701.p.ssafy.io:5000/'));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final accessToken = prefs.getString('accessToken');
        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      },
      onError: (error, handler) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final refreshToken = prefs.getString('refreshToken');
        final userUid = prefs.getInt('userUid');

        // accessToken 만료 됐을 때
        if (error.response?.statusCode == 403) {
          Response response = await _dio.post(
            'api/login/reissuance',
            options: Options(headers: {'refreshToken': 'Bearer $refreshToken'}),
            data: {'userUid': userUid},
          );
          if (response.statusCode! < 400) {
            final clonedRequest = await _dio.request(error.requestOptions.path,
                options: Options(
                    method: error.requestOptions.method,
                    headers: error.requestOptions.headers),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters);
            return handler.resolve(clonedRequest);
          }
          return handler.next(error);
        }
      },
    ));
  }

  Dio getDio() {
    return _dio;
  }
}

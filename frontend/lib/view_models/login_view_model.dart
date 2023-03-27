import 'package:danim/main.dart';
import 'package:danim/models/dto/Token.dart';
import 'package:danim/services/user_repository.dart';
import 'package:danim/view_models/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  var logger = Logger();

  Future<void> loginButtonPressed(context) async {
    bool isInstalled = await isKakaoTalkInstalled();
    OAuthToken token = isInstalled
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();
    final accessToken = token.accessToken;
    final refreshToken = token.refreshToken;
    Token ourToken = await UserRepository().kakaoLogin(
        Token(accessToken: accessToken, refreshToken: refreshToken));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', ourToken.accessToken);
    await prefs.setString('refreshToken', ourToken.refreshToken);
    final String profileImageUrl =
        await UserRepository().getUserProfileImageUrl(ourToken);
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => AppViewModel(
                profileImageUrl: profileImageUrl,
              ),
            ),
          ],
          child: MyHomePage(),
        ),
      ),
    );
  }
}

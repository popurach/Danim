import 'package:danim/view_models/app_view_model.dart';
import 'package:danim/views/bottom_navigation.dart';
import 'package:danim/views/camera_floating_action_button.dart';
import 'package:danim/views/custom_app_bar.dart';
import 'package:danim/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'models/UserInfo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // 추가
  KakaoSdk.init(nativeAppKey: dotenv.env['nativeAppKey']);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AppViewModel(
                UserInfo(
                  userUid: -1,
                  profileImageUrl: '',
                  nickname: '',
                ),
                '홈')),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Danim',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Consumer<AppViewModel>(builder: (_, viewModel, __) {
      return WillPopScope(
        onWillPop: () async {
          bool ret = false;
          if (viewModel.homeFeedNavigatorKey.currentState != null &&
              viewModel.homeFeedNavigatorKey.currentState!.canPop()) {
            viewModel.changeTitle('홈');
            viewModel.homeFeedNavigatorKey.currentState!.pop();
            return false;
          } else if (viewModel.myFeedNavigatorKey.currentState != null &&
              viewModel.myFeedNavigatorKey.currentState!.canPop()) {
            viewModel.changeTitle('내 다님');
            viewModel.myFeedNavigatorKey.currentState!.pop();
            return false;
          } else if (!Navigator.canPop(context)) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('다님 종료'),
                content: const Text('다님을  종료하시겠습니까?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ret = true;
                    },
                    child: const Text(
                      '종료',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('취소'),
                  ),
                ],
              ),
            );
          }
          return ret;
        },
        child: Scaffold(
          appBar: CustomAppBar(
            moveToModifyProfile: () {
              viewModel.goModifyProfilePage();
            },
            logout: () {
              viewModel.logout(context);
            },
          ),
          body: PageView(
            controller: viewModel.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Navigator(
                key: viewModel.homeFeedNavigatorKey,
                onGenerateRoute: (settings) {
                  return viewModel.onHomeFeedRoute(context, settings);
                },
              ),
              Navigator(
                key: viewModel.myFeedNavigatorKey,
                onGenerateRoute: (settings) {
                  return viewModel.onMyFeedRoute(context, settings);
                },
              )
            ],
          ),
          resizeToAvoidBottomInset: true,
          floatingActionButton: Visibility(
            visible: !keyboardIsOpen,
            child: CameraFloatingActionButton(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: CustomBottomNavigationBar(),
        ),
      );
    });
  }
}

import 'dart:io';

import 'package:danim/module/bottom_navigation.dart';
import 'package:danim/module/camera_floating_action_button.dart';
import 'package:danim/module/custom_app_bar.dart';
import 'package:danim/view_models/app_view_model.dart';
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
              '홈'),
        ),
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
      home: const LoginPage(),
      routes: {
        '/login': (_) => const LoginPage(),
        '/home': (_) => const MyHomePage()
      },
    );
  }
}

var logger = Logger();

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Consumer<AppViewModel>(builder: (context, viewModel, __) {
      return WillPopScope(
        onWillPop: () async {
          logger.d('back button pressed..');
          viewModel.changeTitleToFormer();
          logger.d('whats wrong?');
          if (viewModel.homeFeedNavigatorKey.currentState != null &&
              viewModel.homeFeedNavigatorKey.currentState!.canPop()) {
            viewModel.homeFeedNavigatorKey.currentState!.pop();
            logger.d('homeFeed detected');

            return false;
          } else if (viewModel.myFeedNavigatorKey.currentState != null &&
              viewModel.myFeedNavigatorKey.currentState!.canPop()) {
            logger.d('myfeed detected');
            Navigator.pushNamedAndRemoveUntil(
              viewModel.myFeedNavigatorKey.currentContext!,
              '/',
              (routes) => false,
            );
            return false;
          }
          if (!Navigator.canPop(context)) {
            logger.d('exit called');
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (ctx) => WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  title: const Text('다님 종료'),
                  content: const Text('다님을  종료 하시겠습니까?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        exit(0);
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
              ),
            );
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: CustomAppBar(
            moveToModifyProfile: () {
              viewModel.goModifyProfilePage();
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
              ),
            ],
          ),
          resizeToAvoidBottomInset: true,
          floatingActionButton: Visibility(
            visible: !keyboardIsOpen,
            child: const CameraFloatingActionButton(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: CustomBottomNavigationBar(),
        ),
      );
    });
  }
}

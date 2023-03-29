import 'package:danim/view_models/app_view_model.dart';
import 'package:danim/views/bottom_navigation.dart';
import 'package:danim/views/camera_floating_action_button.dart';
import 'package:danim/views/custom_app_bar.dart';
import 'package:danim/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // 추가
  KakaoSdk.init(nativeAppKey: dotenv.env['nativeAppKey']);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppViewModel()),
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
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return WillPopScope(
        onWillPop: () async {
          if (viewModel.homeFeedNavigatorKey.currentState != null &&
              viewModel.homeFeedNavigatorKey.currentState!.canPop()) {
            viewModel.homeFeedNavigatorKey.currentState!.pop();
            return false;
          } else if (viewModel.myFeedNavigatorKey.currentState != null &&
              viewModel.myFeedNavigatorKey.currentState!.canPop()) {
            viewModel.myFeedNavigatorKey.currentState!.pop();
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: CustomAppBar(),
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
                  return viewModel.onMyFeedRoute(settings);
                },
              )
            ],
          ),
          floatingActionButton: const CameraFloatingActionButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: CustomBottomNavigationBar(),
        ),
      );
    });
  }
}

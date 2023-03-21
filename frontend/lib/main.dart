import 'package:danim/view_models/appbar_bottom_navigation_view_model.dart';
import 'package:danim/views/my_appbar_bottom_navigation_frame.dart';
import 'package:danim/views/timeline_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppbarBottomNavigationViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: MyAppbarBottomNavigationFrame(body: TimeLineList()),
        routes: {
          '/home': (_) => MyAppbarBottomNavigationFrame(body: TimeLineList()),
          // '/my': (_) => MyAppbarBottomNavigationFrame(body: MyHomePage()),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyAppbarBottomNavigationFrame(body: TimeLineList());
  }
}

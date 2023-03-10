import 'package:danim/view_models/app_bar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Key key;

  const MyCustomAppBar({required this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppBarViewModel>(
      create: (_) => AppBarViewModel(),
      child: Consumer<AppBarViewModel>(
        builder: (context, model, child) => AppBar(
          actions: model.isLogin
              ? <Widget>[
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://picsum.photos/200/300'),
                    ),
                    onPressed: () {
                      // Add onPressed handler here
                    },
                  ),
                ]
              : null,
          title: const Text("Danim"),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

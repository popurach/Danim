import 'package:danim/view_models/app_bar_view_model.dart';
import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarViewModel viewModel;

  MyCustomAppBar({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: viewModel.isLogin
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

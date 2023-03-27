import 'package:cached_network_image/cached_network_image.dart';
import 'package:danim/view_models/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        Consumer<AppViewModel>(
          builder: (context, viewModel, child) {
            return PopupMenuButton(
              tooltip: '',
              offset: const Offset(0, 55),
              icon: CachedNetworkImage(
                imageUrl: viewModel.profileImageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              iconSize: 40,
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                const PopupMenuItem(
                  child: SizedBox(
                    width: 80,
                    child: Text('프로필변경'),
                  ),
                ),
                const PopupMenuItem(
                  child: SizedBox(
                    width: 80,
                    child: Text('로그아웃'),
                  ),
                )
              ],
            );
          },
        ),
      ],
      title: const Text("Danim"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

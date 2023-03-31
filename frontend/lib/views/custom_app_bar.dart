import 'package:cached_network_image/cached_network_image.dart';
import 'package:danim/view_models/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function moveToModifyProfile;
  final Function logout;

  const CustomAppBar(
      {super.key, required this.moveToModifyProfile, required this.logout});

  @override
  Widget build(BuildContext context) {
    final appViewModel = Provider.of<AppViewModel>(context, listen: true);
    return AppBar(
      actions: [
        PopupMenuButton(
          tooltip: '',
          offset: const Offset(0, 55),
          icon: CachedNetworkImage(
            imageUrl: appViewModel.imageUrl,
            errorWidget: (_, __, ___) => const Icon(Icons.account_circle),
            imageBuilder: (_, imageProvider) => Container(
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
          itemBuilder: (_) => <PopupMenuEntry>[
            PopupMenuItem(
              onTap: () {
                moveToModifyProfile();
              },
              child: const SizedBox(
                width: 80,
                child: Text('프로필변경'),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                logout();
              },
              child: const SizedBox(
                width: 80,
                child: Text('로그아웃'),
              ),
            )
          ],
        ),
      ],
      title: const Text(
        "Danim",
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

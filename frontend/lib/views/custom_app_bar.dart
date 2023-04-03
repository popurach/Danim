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
      leading: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: CircleAvatar(
          foregroundImage: AssetImage('assets/images/transparent_logo.png'),
          backgroundColor: Colors.transparent,
        ),
      ),
      actions: [
        PopupMenuButton(
          tooltip: '',
          offset: const Offset(0, 55),
          icon: CachedNetworkImage(
            imageUrl: appViewModel.imageUrl,
            errorWidget: (_, __, ___) => const Icon(
              Icons.account_circle,
              color: Colors.blueGrey,
            ),
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
                appViewModel.changeTitle('프로필 변경');
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
      title: Text(
        appViewModel.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

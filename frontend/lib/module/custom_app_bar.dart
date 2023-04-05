import 'package:danim/view_models/app_view_model.dart';
import 'package:extended_image/extended_image.dart';
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
        Theme(
          data: Theme.of(context).copyWith(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: PopupMenuButton(
            tooltip: '',
            offset: const Offset(0, 55),
            icon: ExtendedImage.network(
              appViewModel.userInfo.profileImageUrl,
              width: 50,
              height: 50,
              shape: BoxShape.circle,
              fit: BoxFit.cover,
              cache: true,
              borderRadius: BorderRadius.circular(30.0),
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

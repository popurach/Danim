import 'package:danim/view_models/app_view_model.dart';
import 'package:danim/views/login_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function moveToModifyProfile;

  const CustomAppBar({super.key, required this.moveToModifyProfile});

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
              border: Border.all(
                color: Colors.white,
                width: 0.5,
              ),
              shape: BoxShape.circle,
              fit: BoxFit.cover,
              cache: true,
              borderRadius: BorderRadius.circular(30.0),
            ),
            iconSize: 40,
            onSelected: (value) {
              switch (value) {
                case 0:
                  moveToModifyProfile();
                  break;
                case 1:
                  const storage = FlutterSecureStorage();
                  storage.deleteAll();
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const LoginPage(),
                    ),
                    (routes) => false,
                  );
                  break;
              }
            },
            itemBuilder: (context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 0,
                child: SizedBox(
                  width: 80,
                  child: Text('프로필변경'),
                ),
              ),
              const PopupMenuItem(
                value: 1,
                child: SizedBox(
                  width: 80,
                  child: Text(
                    '로그아웃',
                    style: TextStyle(color: Colors.red),
                  ),
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

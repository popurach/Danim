import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<StatefulWidget> createState() => _CustomAppBar();
}

class _CustomAppBar extends State<CustomAppBar> {
  late String _profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    loadProfileImage();
  }

  loadProfileImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final newProfileImage = prefs.getString('profileImageUrl');
    if (newProfileImage != null) changeProfileImageUrl(newProfileImage);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        PopupMenuButton(
          tooltip: '',
          offset: const Offset(0, 55),
          icon: CachedNetworkImage(
            imageUrl: _profileImageUrl,
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
        ),
      ],
      title: const Text("Danim"),
    );
  }

  void changeProfileImageUrl(newImageUrl) {
    setState(() {
      _profileImageUrl = newImageUrl;
    });
  }
}

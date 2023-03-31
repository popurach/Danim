import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function moveToModifyProfile;
  final Function logout;
  const CustomAppBar(
      {super.key, required this.moveToModifyProfile, required this.logout});

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
    const storage = FlutterSecureStorage();
    final newProfileImage = await storage.read(key: 'profileImageUrl');
    if (newProfileImage != null) changeProfileImageUrl(newProfileImage);
  }

  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    return AppBar(
      actions: <Widget>[
        PopupMenuButton(
          tooltip: '',
          offset: const Offset(0, 55),
          icon: CachedNetworkImage(
            imageUrl: _profileImageUrl,
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
                logger.d('modifyProfile clicked');
                widget.moveToModifyProfile();
              },
              child: const SizedBox(
                width: 80,
                child: Text('프로필변경'),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                widget.logout();
              },
              child: const SizedBox(
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

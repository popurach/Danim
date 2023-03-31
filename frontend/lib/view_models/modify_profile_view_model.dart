import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ModifyProfileViewModel extends ChangeNotifier {
  final controller = TextEditingController();
  late final _imagePath;
  var _selectedImageFile;
  var _nickname;

  checkDuplicate() {
    // TODO check Duplicate to Server
    notifyListeners();
  }

  ModifyProfileViewModel() {
    // TODO get nickname and ProfileImage from Server
    _nickname = '호준진심펀치';
    _imagePath = 'https://picsum.photos/200/300';
    controller.text = _nickname;
  }

  sendModifyProfile() {
    // TODO Modify Profile request to Server
  }

  changeProfileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  get isValid => RegExp('^[a-zA-Z가-힣0-9]{3,10}').hasMatch(nickname);

  get imagePath => _imagePath;

  get selectedImageFile => _selectedImageFile;

  set imagePath(value) {
    _imagePath = value;
    notifyListeners();
  }

  get nickname => _nickname;

  set nickname(value) {
    _nickname = value;
    notifyListeners();
  }
}

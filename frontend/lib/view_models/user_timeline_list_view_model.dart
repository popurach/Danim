import 'package:flutter/material.dart';

import '../models/UserInfo.dart';

class UserTimelineListViewModel extends ChangeNotifier {
  BuildContext context;
  UserInfo? userInfo;
  UserInfo myInfo;

  UserTimelineListViewModel({required this.context, required this.myInfo, this.userInfo});
}
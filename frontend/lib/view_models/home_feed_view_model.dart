import 'package:flutter/widgets.dart';

class HomeFeedViewModel extends ChangeNotifier {
  final navigatorKey = GlobalKey<NavigatorState>();
  final timelineListPage = '/timeline-list';
  final timelineDetailPage = '/detail';
  final modifyProfilePage = '/modify-profile';
}

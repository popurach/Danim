import 'package:flutter/widgets.dart';

class HomeFeedViewModel extends ChangeNotifier {
  final navigatorKey = GlobalKey<NavigatorState>();

  final String initPage = '/timeline-list';
}

import 'package:flutter/cupertino.dart';

class PostDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(),
    );
  }
}

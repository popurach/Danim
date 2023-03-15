import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:provider/provider.dart';

import '../view_models/camera_view_model.dart';
import 'camera_screen.dart';

class CameraFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: const Icon(Icons.camera),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                          create: (_) => CameraViewModel(),
                          child: CameraView())));
            },
          ),
        ));
  }
}

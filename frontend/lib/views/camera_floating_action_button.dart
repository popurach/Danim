import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/camera_view_model.dart';
import 'camera_screen.dart';

class CameraFloatingActionButton extends StatelessWidget {
  const CameraFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      width: 70.0,
      child: FittedBox(
        child: FloatingActionButton(
          child: const Icon(Icons.camera),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (_) => CameraViewModel(),
                  child: CameraView(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:danim/view_models/app_view_model.dart';
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
        child: Consumer<AppViewModel>(
          builder: (_, appViewModel, __) {
            return FloatingActionButton(
              child: appViewModel.userInfo.timeLineId == -1
                  ? Image.asset(
                      'assets/images/transparent_logo.png',
                      width: 50,
                      height: 50,
                    )
                  : const Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
              onPressed: () {
                if (appViewModel.userInfo.timeLineId == -1) {
                  // 여행 중이 아닐 때
                  appViewModel.startTravel(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (_) => CameraViewModel(),
                        child: CameraView(),
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

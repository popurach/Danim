import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/app_scroll_behavior.dart';
import '../view_models/images_page_view_model.dart';

class ImagesPageView extends StatelessWidget {
  const ImagesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagesPageViewModel>(
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            PageView(
              scrollBehavior: AppScrollBehavior(),
              controller: viewModel.controller,
              children: viewModel.imageList,
            ),
            Align(
              alignment: const AlignmentDirectional(0, -0.9),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: SmoothPageIndicator(
                  controller: viewModel.controller,
                  count: viewModel.imageList.length,
                  onDotClicked: (index) {
                    viewModel.controller.animateToPage(index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

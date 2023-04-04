import 'package:danim/view_models/user_timeline_list_view_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserTimelineListViewModel>(
        builder: (context, userTimelineListViewModel, _) {
      return Container(
        height: 100,
        margin: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black54)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 4,
              child: ExtendedImage.network(
                userTimelineListViewModel.userInfo.profileImageUrl,
                cache: true,
              ),
            ),
            const Expanded(
                flex: 1, child: VerticalDivider(color: Colors.black54)),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(userTimelineListViewModel.userInfo!.nickname),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("총 여행 수 들어갈 예정"),
                      userTimelineListViewModel.userInfo?.timeLineId == -1
                          ? Text("휴식중")
                          : Text("여행중")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

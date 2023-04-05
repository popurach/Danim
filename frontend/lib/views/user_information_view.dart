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
        height: 80,
        margin: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black54)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(9.0)),
                child: ExtendedImage.network(
                  userTimelineListViewModel.userInfo.profileImageUrl,
                  fit: BoxFit.cover,
                  cache: true,
                ),
              ),
            ),
            const VerticalDivider(
              color: Colors.black54,
              width: 1,
            ),
            Expanded(
              flex: 11,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        '이름',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 39,
                        ),
                      ),
                      Text(
                        '다님수',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 13,
                        ),
                      ),
                      Text(
                        '상태',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 39,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userTimelineListViewModel.userInfo.nickname),
                      Text(userTimelineListViewModel.userInfo.timelineNum
                          .toString()),
                      Text(
                        userTimelineListViewModel.userInfo.timeLineId == -1
                            ? '휴식중...'
                            : '다님중!',
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

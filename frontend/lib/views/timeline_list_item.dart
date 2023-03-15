import 'package:danim/models/Timeline.dart';
import 'package:danim/view_models/timeline_detail_view_model.dart';
import 'package:danim/views/timeline_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimelineListItem extends StatelessWidget {
  final Timeline timeline;

  const TimelineListItem(this.timeline, {super.key});

  @override
  Widget build(BuildContext context) {
    const cardHeight = 140.0;

    return Container(
        margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
        height: cardHeight,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      ChangeNotifierProvider(
                    create: (_) => TimelineDetailViewModel(
                      timelineId: timeline.timelineId,
                    ),
                    child: const TimelineDetail(),
                  ),
                  transitionDuration: Duration.zero,
                ));
          },
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.black45, width: 1.5),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                            height: cardHeight * 0.2,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                SizedBox(width: 30),
                                Text(
                                  "Danim",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.flight_takeoff,
                                  color: Colors.white,
                                ),
                                Expanded(
                                    child: Text(
                                  '서울 ~ 파리',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Colors.white),
                                )),
                                SizedBox(width: 30)
                              ],
                            )),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, bottom: 10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image(
                                  image: NetworkImage(timeline.imageUrl),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 90,
                                          child: Text(
                                            "T   I  T  L  E",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(child: Text(timeline.title))
                                      ],
                                    )),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 90,
                                          child: Text(
                                            "TRAVELER",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                                timeline.userId.toString())),
                                      ],
                                    )),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 90,
                                          child: Text("DURATION",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Expanded(
                                            child: Text(
                                                '${timeline.createTime} ~ ${timeline.modifyTime}'))
                                      ],
                                    )),
                                  ])),
                            ],
                          ),
                        ))
                      ],
                    ),
                  )
                ],
              )),
        ));
  }
}

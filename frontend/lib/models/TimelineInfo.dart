import 'package:danim/models/TimelineDetail.dart';

class TimelineInfo {
  final List<TimelineDetail> timelineDetails;
  final bool isComplete;
  bool isPublic;

  TimelineInfo({
    required this.timelineDetails,
    required this.isPublic,
    required this.isComplete,
  });

  factory TimelineInfo.fromJson(Map<String, dynamic> json) {
    return TimelineInfo(
      timelineDetails: List.from(json['timeline']
          .map((timelineDetail) => TimelineDetail.fromJson(timelineDetail))),
      isPublic: json['isPublic'],
      isComplete: json['isComplete'],
    );
  }
}

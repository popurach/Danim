// Timeline DTO
import 'Post.dart';

class Timeline {
  final int timelineId;
  final int userId;
  final String title;
  final String createTime;
  final String modifyTime;
  final bool complete;
  final bool timelinePublic;
  final String imageUrl;
  final List<Post> post;

  Timeline(
      {required this.timelineId,
      required this.userId,
      required this.title,
      required this.createTime,
      required this.modifyTime,
      required this.complete,
      required this.imageUrl,
      required this.timelinePublic,
      required this.post});

  // Serialize(직렬화) Timeline객체 -> JSON객체
  Map<String, dynamic> toJson() => {
        'timelineId': timelineId,
        'userId': userId,
        'title': title,
        'createTime': createTime,
        'modifyTime': modifyTime,
        'complete': complete,
        'imageUrl': imageUrl,
        'timelinePublic': timelinePublic,
        'post': post
      };

  // Deserialize(파싱?) JSON객체 -> Timeline객체
  factory Timeline.fromJson(Map<String, dynamic> json) {
    return Timeline(
        timelineId: json['timelineId'],
        userId: json['userId'],
        title: json['title'],
        createTime: json['createTime'],
        modifyTime: json['modifyTime'],
        complete: json['complete'],
        imageUrl: json['imageUrl'],
        timelinePublic: json['timelinePublic'],
        post: json['post']);
  }
}

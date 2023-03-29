import 'package:danim/models/Post.dart';

class TimelineDetail {
  final String flag;
  final String nation;
  final List<Post> postList;

  TimelineDetail({
    required this.flag,
    required this.nation,
    required this.postList,
  });

  Map<String, dynamic> toJson(json) => {
        'flag': flag,
        'nation': nation,
        'postList': postList.map((post) => post.toJson()),
      };

  factory TimelineDetail.fromJson(Map<String, dynamic> json) => TimelineDetail(
        flag: json['flag'],
        nation: json['nation'],
        postList: List.from(
            json['postList'].map((jsonPost) => Post.fromJson(jsonPost))),
      );
}

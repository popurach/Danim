import 'package:danim/models/Post.dart';

class TimelineDetail {
  final String flag;
  final String nation;
  final List<Post> postList;
  final bool isMine;
  bool isExpand;

  TimelineDetail({
    required this.flag,
    required this.nation,
    required this.postList,
    required this.isMine,
    this.isExpand = false,
  });

  @override
  String toString() {
    return 'TimelineDetail{flag: $flag, nation: $nation, postList: $postList, isExpand: $isExpand}';
  }

  factory TimelineDetail.fromJson(Map<String, dynamic> json) => TimelineDetail(
      flag: json['flag'],
      nation: json['nation'],
      postList: List.from(
          json['postList'].map((jsonPost) => Post.fromJson(jsonPost))),
      isMine: json['isMine']);
}

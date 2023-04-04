class UserInfo {
  final int userUid;
  final String profileImageUrl;
  final String nickname;
  int timeLineId;

  UserInfo({
    required this.userUid,
    required this.profileImageUrl,
    required this.nickname,
    this.timeLineId = -1,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userUid: json['userUid'],
      profileImageUrl: json['profileImageUrl'],
      nickname: json['nickname'],
      timeLineId: json['timeLineId'] ?? -1,
    );
  }
}

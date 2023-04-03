class UserInfo {
  final int userUid;
  final String profileImageUrl;
  final String nickname;
  final int travelingId;

  UserInfo({
    required this.userUid,
    required this.profileImageUrl,
    required this.nickname,
    this.travelingId = -1,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userUid: json['userUid'],
      profileImageUrl: json['profileImageUrl'],
      nickname: json['nickname'],
      travelingId: json['travelingId'] ?? -1,
    );
  }
}

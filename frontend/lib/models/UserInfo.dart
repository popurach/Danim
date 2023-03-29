class UserInfo {
  final int userUid;
  final String profileImageUrl;
  final String nickname;

  UserInfo({
    required this.userUid,
    required this.profileImageUrl,
    required this.nickname,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userUid: json['userUid'],
      profileImageUrl: json['profileImageUrl'],
      nickname: json['nickname'],
    );
  }
}

class UserInfo {
  final int userUid;
  final String profileImageUrl;
  final String nickname;
  final bool isTraveling;

  UserInfo({
    required this.userUid,
    required this.profileImageUrl,
    required this.nickname,
    this.isTraveling = false,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userUid: json['userUid'],
      profileImageUrl: json['profileImageUrl'],
      nickname: json['nickname'],
      isTraveling: json['isTraveling'] ?? false,
    );
  }
}

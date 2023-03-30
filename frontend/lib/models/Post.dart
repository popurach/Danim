class Post {
  final int postId;
  final String voiceUrl;
  final double voiceLength;
  final String address;
  final String text;
  final List<String> photoList;
  bool isFavorite;
  int favoriteCount;
  final bool isMine;
  bool isExpand;

  Post({
    required this.postId,
    required this.voiceUrl,
    required this.voiceLength,
    required this.address,
    required this.text,
    required this.photoList,
    required this.isFavorite,
    required this.favoriteCount,
    required this.isMine,
    this.isExpand = false,
  });

  // Deserialize(파싱?)
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'],
      voiceUrl: json['voiceUrl'],
      voiceLength: json['voiceLength'],
      address: (json['address2'] ?? '') +
          ' ' +
          (json['address3'] ?? '') +
          ' ' +
          (json['address4'] ?? ''),
      text: json['text'],
      photoList: List.from(json['photoList']),
      isFavorite: json['isFavorite'],
      favoriteCount: json['favoriteCount'],
      isMine: json['isMine'],
    );
  }
}

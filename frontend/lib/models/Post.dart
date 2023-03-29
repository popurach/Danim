class Post {
  final int postId;
  final String voiceUrl;
  final double voiceLength;
  final String? address2;
  final String? address3;
  final String? address4;
  final String text;
  final List<String> photoList;
  final bool isLike;

  Post({
    required this.postId,
    required this.voiceUrl,
    required this.voiceLength,
    required this.address2,
    required this.address3,
    required this.address4,
    required this.text,
    required this.photoList,
    required this.isLike,
  });

  // Serialize(직렬화)
  Map<String, dynamic> toJson() => {
        'postId': postId.toString(),
        'voiceUrl': voiceUrl,
        'voiceLength': voiceLength.toString(),
        'address2': address2,
        'address3': address3,
        'address4': address4,
        'text': text,
        'photoList': photoList,
        'isLike': isLike,
      };

  // Deserialize(파싱?)
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'],
      voiceUrl: json['voiceUrl'],
      voiceLength: json['voiceLength'],
      address2: json['address2'],
      address3: json['address3'],
      address4: json['address4'],
      text: json['text'],
      photoList: List.from(json['photoList']),
      isLike: false,
    );
  }
}

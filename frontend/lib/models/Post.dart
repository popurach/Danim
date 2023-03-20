class Post {
  final List<String> imageUrls;
  final String voiceUrl;
  final String voiceLength;
  final String text;
  final bool isLike;

  Post(
      {required this.imageUrls,
      required this.voiceUrl,
      required this.voiceLength,
      required this.text,
      required this.isLike});

  // Serialize(직렬화)
  Map<String, dynamic> toJson() => {
        'imageUrls': imageUrls,
        'voiceUrl': voiceUrl,
        'voiceLength': voiceLength,
        'text': text,
        'isLike': isLike,
      };

  // Deserialize(파싱?)
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      imageUrls: json['imageUrls'],
      voiceUrl: json['voiceUrl'],
      voiceLength: json['voiceLength'],
      text: json['text'],
      isLike: json['isLike'],
    );
  }
}

class CommentModel {
  final String id;
  final String userName;
  final String? userAvatar;
  final String content;
  final String createdAt;

  CommentModel({
    required this.id,
    required this.userName,
    this.userAvatar,
    required this.content,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'] ?? '',
      userName: json['userName'] ?? '',
      userAvatar: json['userAvatar'],
      content: json['content'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}

class VideoModel {
  final String id;
  final String title;
  final String author;
  final String authorAvatar;
  final int likes;
  final int dislikes;
  final int views;
  final String description;
  final String videoUrl;
  final String createdAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.author,
    required this.authorAvatar,
    required this.likes,
    required this.dislikes,
    required this.views,
    required this.description,
    required this.videoUrl,
    required this.createdAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      authorAvatar: json['authorAvatar'] ?? '',
      likes: json['likes'] ?? 0,
      dislikes: json['dislikes'] ?? 0,
      views: json['views'] ?? 0,
      description: json['description'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}

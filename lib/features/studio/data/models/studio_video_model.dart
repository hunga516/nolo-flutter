class StudioVideoModel {
  final String id;
  final String title;
  final String? description;
  final String? thumbnail;
  final String? duration;
  final bool isPrivate;

  StudioVideoModel({
    required this.id,
    required this.title,
    this.description,
    this.thumbnail,
    this.duration,
    this.isPrivate = false,
  });

  factory StudioVideoModel.fromJson(Map<String, dynamic> json) {
    return StudioVideoModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      thumbnail: json['thumbnail'],
      duration: json['duration'] ?? '0:00',
      isPrivate: json['isPrivate'] ?? false,
    );
  }
}

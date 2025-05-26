class LiveStreamModel {
  final String id;
  final String? thumbnail;
  final bool isActive;
  final String? duration;

  LiveStreamModel({
    required this.id,
    this.thumbnail,
    this.isActive = false,
    this.duration,
  });

  factory LiveStreamModel.fromJson(Map<String, dynamic> json) {
    return LiveStreamModel(
      id: json['_id'] ?? '',
      thumbnail: json['thumbnail'],
      isActive: json['isActive'] ?? false,
      duration: json['duration'] ?? '0:00',
    );
  }
}

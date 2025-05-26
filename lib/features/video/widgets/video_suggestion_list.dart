import 'package:flutter/material.dart';
import '../data/models/video_model.dart';
import '../data/services/video_service.dart';

class VideoSuggestionList extends StatelessWidget {
  final void Function(VideoModel)? onTap;
  const VideoSuggestionList({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VideoModel>>(
      future: VideoService().fetchSuggestions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        }
        final videos = snapshot.data ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Có thể bạn thích',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...videos.take(5).map((video) => _VideoSuggestionItem(
                  video: video,
                  onTap: () => onTap?.call(video),
                )),
          ],
        );
      },
    );
  }
}

class _VideoSuggestionItem extends StatelessWidget {
  final VideoModel video;
  final VoidCallback? onTap;
  const _VideoSuggestionItem({required this.video, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail video
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    video.videoUrl.isNotEmpty
                        ? video.videoUrl
                        : 'https://via.placeholder.com/300x180?text=Video',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _formatDuration(video),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Tiêu đề và thông tin
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green[200],
                  backgroundImage: video.authorAvatar.isNotEmpty
                      ? NetworkImage(video.authorAvatar)
                      : null,
                  child: video.authorAvatar.isEmpty
                      ? Text(video.author.isNotEmpty ? video.author[0] : 'N', style: const TextStyle(color: Colors.white))
                      : null,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${video.author} • ${_timeAgo(video.createdAt)}',
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(VideoModel video) {
    // Giả lập, bạn có thể lấy duration từ API nếu có
    if (video.title.contains('aaa')) return '14:50';
    return '00:28';
  }

  String _timeAgo(String createdAt) {
    if (createdAt.contains('tháng')) return 'khoảng 1 tháng trước';
    return '26 ngày trước';
  }
}

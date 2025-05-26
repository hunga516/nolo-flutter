import 'package:flutter/material.dart';
import '../../data/models/studio_video_model.dart';
import '../../data/services/studio_video_service.dart';

class StudioPage extends StatelessWidget {
  const StudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.menu, size: 28),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Nội dung',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.upload, color: Colors.black),
                label: const Text('Tải lên', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  side: const BorderSide(color: Colors.black12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
              const SizedBox(width: 12),
              const CircleAvatar(
                backgroundImage: NetworkImage('https://i.imgur.com/BoN9kdC.png'),
                radius: 20,
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Quản lý các nội dung và video của bạn',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 24),
          // Tiêu đề cột
          Row(
            children: const [
              Expanded(
                flex: 2,
                child: Text('Video', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 1,
                child: Text('Visibility', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const Divider(height: 24),
          // Danh sách video
          FutureBuilder<List<StudioVideoModel>>(
            future: StudioVideoService().fetchMyVideos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text('Lỗi: ${snapshot.error}'));
              }
              final videos = snapshot.data ?? [];
              if (videos.isEmpty) {
                return const Center(child: Text('Bạn chưa có video nào.'));
              }
              return Column(
                children: [
                  ...videos.map((video) => _StudioVideoItem(video: video)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text('Xem thêm'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StudioVideoItem extends StatelessWidget {
  final StudioVideoModel video;
  const _StudioVideoItem({required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.grey[400],
              width: 90,
              height: 60,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  video.thumbnail != null
                      ? Image.network(video.thumbnail!, width: 90, height: 60, fit: BoxFit.cover)
                      : const Icon(Icons.sentiment_dissatisfied, size: 36, color: Colors.black),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        video.duration ?? '0:00',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Tiêu đề & mô tả
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  video.description ?? 'Không có mô tả',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Visibility
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Icon(
                  video.isPrivate ? Icons.lock : Icons.public,
                  color: Colors.grey[700],
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  video.isPrivate ? 'Riêng tư' : 'Công khai',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

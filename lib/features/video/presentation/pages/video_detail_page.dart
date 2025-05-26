import 'package:flutter/material.dart';
import '../../data/models/video_model.dart';
import '../../data/services/video_service.dart';
import '../../widgets/video_player_widget.dart';
import '../../widgets/video_action_buttons.dart';
import '../../widgets/video_suggestion_list.dart';
import '../../widgets/comment_section.dart';

class VideoDetailPage extends StatelessWidget {
  final String videoId;
  const VideoDetailPage({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<VideoModel>(
        future: VideoService().fetchVideoDetail(videoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }
          final video = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Thanh đăng nhập & tìm kiếm
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text('Đăng nhập'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm ...',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Breadcrumb
              Row(
                children: const [
                  Text('Trang chủ', style: TextStyle(color: Colors.grey)),
                  Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                  Text('...', style: TextStyle(color: Colors.grey)),
                  Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                  Text('Cửa hàng', style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 16),
              // Video player
              VideoPlayerWidget(videoUrl: video.videoUrl),
              const SizedBox(height: 16),
              // Tiêu đề
              Text(
                video.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              // Thông tin người đăng
              Row(
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
                    child: Text(
                      video.author,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    '1 người đăng ký',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: const Text('Theo dõi'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Nút like/dislike/share
              VideoActionButtons(likes: video.likes, dislikes: video.dislikes),
              const SizedBox(height: 16),
              // Thông tin video
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${video.views} lượt xem   ${video.createdAt}', style: const TextStyle(color: Colors.black87)),
                    const SizedBox(height: 4),
                    Text(video.description, style: const TextStyle(color: Colors.black54)),
                    const SizedBox(height: 4),
                    const Text('Xem thêm', style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              VideoSuggestionList(
                onTap: (suggestedVideo) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VideoDetailPage(videoId: suggestedVideo.id),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              CommentSection(videoId: video.id),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text('N'),
      ),
    );
  }
}
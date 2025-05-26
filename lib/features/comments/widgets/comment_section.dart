import 'package:flutter/material.dart';
import '../data/models/comment_model.dart';
import '../data/services/comment_service.dart';

class CommentSection extends StatefulWidget {
  final String videoId;
  const CommentSection({super.key, required this.videoId});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<CommentModel>> _futureComments;

  @override
  void initState() {
    super.initState();
    _futureComments = CommentService().fetchComments(widget.videoId);
  }

  void _refreshComments() {
    setState(() {
      _futureComments = CommentService().fetchComments(widget.videoId);
    });
  }

  void _postComment() async {
    final content = _controller.text.trim();
    if (content.isEmpty) return;
    try {
      await CommentService().postComment(widget.videoId, content);
      _controller.clear();
      _refreshComments();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gửi bình luận thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<List<CommentModel>>(
          future: _futureComments,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final comments = snapshot.data ?? [];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${comments.length} comments',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Đăng bình luận của bạn ...',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _postComment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      child: const Text('Bình luận'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...comments.map((c) => _CommentItem(comment: c)),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _CommentItem extends StatelessWidget {
  final CommentModel comment;
  const _CommentItem({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[200],
            backgroundImage: comment.userAvatar != null && comment.userAvatar!.isNotEmpty
                ? NetworkImage(comment.userAvatar!)
                : null,
            child: (comment.userAvatar == null || comment.userAvatar!.isEmpty)
                ? Text(
                    comment.userName.isNotEmpty ? comment.userName[0] : 'N',
                    style: const TextStyle(color: Colors.white),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  comment.content,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _timeAgo(comment.createdAt),
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }

  String _timeAgo(String createdAt) {
    // Giả lập, bạn có thể dùng package timeago hoặc tự xử lý
    if (createdAt.contains('tháng')) return 'khoảng 1 tháng trước';
    if (createdAt.contains('ngày')) return createdAt;
    return '23 ngày trước';
  }
}


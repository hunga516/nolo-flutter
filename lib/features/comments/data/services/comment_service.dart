import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comment_model.dart';

class CommentService {
  static const String baseUrl = 'https://nolo-backend.onrender.com';

  Future<List<CommentModel>> fetchComments(String videoId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/videos/$videoId/comments'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['data'];
      return list.map((e) => CommentModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<void> postComment(String videoId, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/videos/$videoId/comments'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'content': content}),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to post comment');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/video_model.dart';

class VideoService {
  static const String baseUrl = 'https://nolo-backend.onrender.com';

  Future<VideoModel> fetchVideoDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/videos/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return VideoModel.fromJson(data['data']);
    } else {
      throw Exception('Failed to load video');
    }
  }

  Future<List<VideoModel>> fetchSuggestions() async {
    final response = await http.get(Uri.parse('$baseUrl/api/videos'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['data'];
      return list.map((e) => VideoModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load suggestions');
    }
  }
}
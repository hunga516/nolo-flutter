import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/studio_video_model.dart';

class StudioVideoService {
  static const String baseUrl = 'https://nolo-backend.onrender.com';

  Future<List<StudioVideoModel>> fetchMyVideos() async {
    final response = await http.get(Uri.parse('$baseUrl/api/videos?owner=me'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['data'];
      return list.map((e) => StudioVideoModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }

  Future<void> createOrUpdateVideo(Map<String, dynamic> data, {String? id}) async {
    final url = id == null
        ? '$baseUrl/api/videos'
        : '$baseUrl/api/videos/$id';
    final response = await (id == null
        ? http.post(Uri.parse(url), body: json.encode(data), headers: {'Content-Type': 'application/json'})
        : http.put(Uri.parse(url), body: json.encode(data), headers: {'Content-Type': 'application/json'}));
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Lưu video thất bại');
    }
  }
}

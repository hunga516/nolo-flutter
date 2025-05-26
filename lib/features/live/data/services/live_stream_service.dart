import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/live_stream_model.dart';

class LiveStreamService {
  static const String baseUrl = 'https://nolo-backend.onrender.com';

  Future<List<LiveStreamModel>> fetchLiveStreams() async {
    final response = await http.get(Uri.parse('$baseUrl/api/livestreams'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['data'];
      return list.map((e) => LiveStreamModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load live streams');
    }
  }
}

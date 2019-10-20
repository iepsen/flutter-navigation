import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/video.dart';

class VideoService {
  final String key = "AIzaSyD-mma7efrJHHsUIp2lwZElkz1PCPLzIpc";
  final String channelId = "UC-OjykH8z-DrOMJmait_-vw";
  final String part = "snippet";
  final String maxResults = "50";
  final String apiUrl = "https://www.googleapis.com/youtube/v3/search";

  String buildRequestUrl() {
   return "${this.apiUrl}?part=${this.part}&channelId=${this.channelId}&key=${this.key}&maxResults=${this.maxResults}";
  }

  Future<List<Video>> fetchVideos() async {
  final response = await http.get(this.buildRequestUrl());

  if (response.statusCode == 200) {
    dynamic body = json.decode(response.body);
    Iterable list = body['items'];
    return list.map((model) => Video.fromJson(model)).toList();
  } else {
    throw Exception('Failed to load photos');
  }
}
}
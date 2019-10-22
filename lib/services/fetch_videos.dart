import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/video.dart';

class VideoService {
  final String playlistId = "2114913880001";
  final String apiUrl = "https://video.foxnews.com/v/feed/playlist";

  String buildRequestUrl() {
   return "${this.apiUrl}/${this.playlistId}.json?template=fox";
  }

  Future<List<Video>> fetchVideos() async {
  final response = await http.get(this.buildRequestUrl());

  if (response.statusCode == 200) {
    dynamic body = json.decode(response.body);
    Iterable list = body['channel']['item'];
    return list.map((model) => Video.fromJson(model)).toList();
  } else {
    throw Exception('Failed to load photos');
  }
}
}
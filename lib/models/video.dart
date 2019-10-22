import 'package:flutter/cupertino.dart';

class Video {
  final String title;
  final String description;
  final String imageUrl;
  final String videoUrl;

  Video({this.title, this.description, this.imageUrl, this.videoUrl});

  factory Video.fromJson(Map<dynamic, dynamic> json) {
    String parseMediaContent(Iterable json) {
      dynamic item = json.singleWhere((videoItem) => videoItem['media-category']['@attributes']['label'] == 'PDL_HIGH', orElse: () => null);
      if (item == null) {
        return '';
      }
      return item['@attributes']['url'];
    }

    return Video(
      title: json['title'],
      description: json['description'],
      imageUrl: json['media-group']['media-thumbnail']['@attributes']['url'],
      videoUrl: parseMediaContent(json['media-group']['media-content']),
    );
  }
}
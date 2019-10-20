class Video {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  Video({this.id, this.title, this.description, this.imageUrl});

  factory Video.fromJson(Map<dynamic, dynamic> json) {
    return Video(
      id: json['id']['videoId'],
      title: json['snippet']['title'],
      description: json['snippet']['description'],
      imageUrl: json['snippet']['thumbnails']['high']['url']
    );
  }
}
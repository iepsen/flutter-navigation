class Photo {
  final String id;
  final String author;
  final String imageUrl;

  Photo({this.id, this.author, this.imageUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      author: json['author'],
      imageUrl: "https://picsum.photos/id/${json['id']}/400/250"
    );
  }
}
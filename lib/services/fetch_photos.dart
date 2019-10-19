import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo.dart';

Future<List<Photo>> fetchPhotos() async {
  final response = await http.get('https://picsum.photos/v2/list');

  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    return list.map((model) => Photo.fromJson(model)).toList();
  } else {
    throw Exception('Failed to load photos');
  }
}
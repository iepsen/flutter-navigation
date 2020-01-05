import 'package:flutter/material.dart';

class SelectedItem extends StatelessWidget {
  final String title;
  final String descritpion;
  final String imageSource;

  SelectedItem({this.title, this.descritpion, this.imageSource});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 800, maxHeight: 400),
      child: Container(
        child: Image(
          image: NetworkImage(imageSource)
        ),
      ),
    );
  }
}
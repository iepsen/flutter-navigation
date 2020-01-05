import 'package:flutter/material.dart';
import 'package:flutter_navigation/components/selected_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          SelectedItem(title: 'Selected Item Title', descritpion: 'Seletec Item Description', imageSource: 'http://hdwpro.com/wp-content/uploads/2016/02/Cool-Beautiful-Wallpaper.jpeg',)
        ],
      ),
    );
  }
}
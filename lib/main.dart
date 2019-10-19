import 'package:flutter/material.dart';
import 'package:flutter_navigation/screens/home_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
      ),
      home: HomeScreen(),
    );
  }
}
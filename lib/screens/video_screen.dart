import 'dart:html';

import 'package:flutter/material.dart';
import '../plugins/player.dart';

class VideoScreen extends StatefulWidget {
  @override
  VideoScreenState createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {

  Player player;

  @override
  void initState() {
    super.initState();
    this.initPlayer();
  }

  void initPlayer() {
    this.player = Player();
    this.player.onCanPlay(this.onCanPlay);
    this.player.onEnded(this.onEnded);
    this.player.onDurationChange(this.onDurationChange);
    this.player.onTimeUpdate(this.onTimeUpdate);
    this.player.initWithSource(src: 'https://archive.org/download/ElephantsDream/ed_1024_512kb.mp4');
  }

  void onCanPlay(Event event) {
    debugPrint('yes, you can play!');
    this.player.play();
  }

  void onEnded(Event event) {
    debugPrint(event.toString());
  }

  void onDurationChange(Event event) {
    debugPrint(event.toString());
  }

  void onTimeUpdate(Event event) {
    debugPrint(this.player.getCurrentTime().toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Container(width: 0, height: 0,);
  }
}
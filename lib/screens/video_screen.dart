import 'dart:html';

import 'package:flutter/material.dart';
import '../plugins/player.dart';

class VideoScreen extends StatefulWidget {
  @override
  VideoScreenState createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {

  Player player;
  IconData _playPauseIcon = Icons.play_arrow;

  @override
  void initState() {
    super.initState();
    this.initPlayer();
  }

  void initPlayer() {
    this.player = Player();
    this.player.onCanPlay(this.onCanPlay);
    this.player.onPlay(this.onPlay);
    this.player.onPause(this.onPause);
    this.player.onEnded(this.onEnded);
    this.player.onDurationChange(this.onDurationChange);
    this.player.onTimeUpdate(this.onTimeUpdate);
    this.player.initWithSource(src: 'https://archive.org/download/ElephantsDream/ed_1024_512kb.mp4');
  }

  void onCanPlay(Event event) {
    this.player.play();
  }

  void onPlay(Event event) {
    debugPrint('onPlay');
    setState(() {
      _playPauseIcon = Icons.pause;
    });
  }

  void onPause(Event event) {
    debugPrint('onPause');
    setState(() {
      _playPauseIcon = Icons.play_arrow;
    });
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

  void tooglePlayPause() {
    this.player.isPlaying() ? this.player.pause() : this.player.play();
  }

  void stop() {
    //
  }

  void back() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: Container(
        width: 600,
        height: 200,
        margin: EdgeInsets.all(20),
        child: DefaultFocusTraversal(
          policy: ReadingOrderTraversalPolicy(),
          child: FocusScope(
            debugLabel: 'IconsBar',
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    iconSize: 50,
                    focusColor: Colors.red,
                    icon: Icon(Icons.arrow_back),
                    autofocus: false,
                    onPressed: this.back
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: 50,
                        focusColor: Colors.red,
                        icon: Icon(_playPauseIcon),
                        autofocus: true,
                        onPressed: this.tooglePlayPause
                      ),
                      IconButton(
                        iconSize: 50,
                        focusColor: Colors.red,
                        icon: Icon(Icons.stop),
                        autofocus: false,
                        onPressed: this.stop
                      )
                    ],
                  )
                )
              ]
            ),
          ),
        ),
      )
    );
  }
}
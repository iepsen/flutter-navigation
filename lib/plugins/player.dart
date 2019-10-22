import 'dart:html';

import 'package:flutter/widgets.dart';

class Player {
  VideoElement player;
  String src;
  Function onCanPlayCallback;
  Function onDurationChangeCallback;
  Function onTimeUpdateCallback;
  Function onPlayingCallback;
  Function onPlayCallback;
  Function onPauseCallback;
  Function onEndedCallback;
 
  void initWithSource({String src}) {
    this.setVideoElement(src);
    this.setListeners();
  }

  void setVideoElement(String src) {
    this.player = querySelector('video');
    this.player.src = src;
    this.player.style.display = 'block';
  }

  void setListeners() {
    this.player.onCanPlay.listen(this.onCanPlayCallback);
    this.player.onDurationChange.listen(this.onDurationChangeCallback);
    this.player.onTimeUpdate.listen(this.onTimeUpdateCallback);
    this.player.onPlaying.listen(this.onPlayingCallback);
    this.player.onPlay.listen(this.onPlayCallback);
    this.player.onPause.listen(this.onPauseCallback);
    this.player.onEnded.listen(this.onEndedCallback);
  }

  void onCanPlay(Function onCanPlayCallback) {
    this.onCanPlayCallback = onCanPlayCallback;
  }

  void onDurationChange(Function onDurationChangeCallback) {
    this.onDurationChangeCallback = onDurationChangeCallback;
  }

  void onTimeUpdate(Function onTimeUpdateCallback) {
    this.onTimeUpdateCallback = onTimeUpdateCallback;
  }

  void onPlaying(Function onPlayingCallback) {
    this.onPlayingCallback = onCanPlayCallback;
  }

  void onPlay(Function onPlayCallback) {
    this.onPlayCallback = onPlayCallback;
  }

  void onPause(Function onPauseCallback) {
    this.onPauseCallback = onPauseCallback;
  }

  void onEnded(Function onEndedCallback) {
    this.onEndedCallback = onEndedCallback;
  }

  void play() {
    this.player.play();
  }

  void pause() {
    this.player.pause();
  }

  bool isPlaying() {
    return !this.player.paused;
  }

  double getCurrentTime() {
    return this.player.currentTime;
  }
}
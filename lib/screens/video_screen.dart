import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class StateColors {
  static final Color normalColor = Colors.white;
  static final Color focusedColor = Colors.red;
}

class VideoScreen extends StatefulWidget {
  
  final String videoUrl;
  
  @override
  VideoScreenState createState() {
   return  VideoScreenState();
  }

  VideoScreen({this.videoUrl});
}

class VideoScreenState extends State<VideoScreen> {

  VideoElement player;
  IconData _playPauseIcon = Icons.play_arrow;
  Color _playPauseColor = Colors.red;
  Color _backColor = Colors.white;
  Color _stopColor = Colors.white;

  @override
  void initState() {
    super.initState();
    this.initPlayer();
    debugPrint('initState');
  }

  void initPlayer() {
    this.player = VideoElement();
    this.player.onCanPlay.listen(this.onCanPlay);
    this.player.onPlay.listen(this.onPlay);
    this.player.onPause.listen(this.onPause);
    this.player.onEnded.listen(this.onEnded);
    this.player.onDurationChange.listen(this.onDurationChange);
    this.player.onTimeUpdate.listen(this.onTimeUpdate);
    this.player.src = widget.videoUrl;

    ui.platformViewRegistry.registerViewFactory(
      'video-player',
      (int viewId) => this.player
    );
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
    // debugPrint(event.toString());
  }

  void onDurationChange(Event event) {
    // debugPrint(event.toString());
  }

  void onTimeUpdate(Event event) {
    // debugPrint(this.player.currentTime.toString());
  }

  void tooglePlayPause() {
    this.player.paused ? this.player.play() : this.player.pause();
  }

  void stop() {
    //
  }

  void back() {
    this.player.pause();
    this.player.remove();
    this.player = null;
    Navigator.pop(context);
  }

  onFocusChangeBackIcon(bool focused) {
      setState(() {
      _backColor = focused ? StateColors.focusedColor : StateColors.normalColor;
    });
  }

  onFocusChangePlayPauseIcon(bool focused) {
      setState(() {
      _playPauseColor = focused ? StateColors.focusedColor : StateColors.normalColor;
    });
  }

  onFocusChangeStopIcon(bool focused) {
      setState(() {
      _stopColor = focused ? StateColors.focusedColor : StateColors.normalColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.canvas,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: HtmlElementView(viewType: 'video-player'),
          ),
          DefaultFocusTraversal(
            policy: ReadingOrderTraversalPolicy(),
            child: Container(
              margin: EdgeInsets.all(20),
              child: FocusScope(
                debugLabel: 'IconsBar',
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        autofocus: false,
                        onFocusChange: onFocusChangeBackIcon,
                        onTap: this.back,
                        child: IconButton(
                          iconSize: 50,
                          icon: Icon(Icons.arrow_back, color: _backColor),
                          autofocus: false,
                          onPressed: this.back
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            autofocus: false,
                            onFocusChange: onFocusChangePlayPauseIcon,
                            child: 
                              IconButton(
                                iconSize: 50,
                                icon: Icon(_playPauseIcon, color: _playPauseColor),
                                autofocus: true,
                                onPressed: this.tooglePlayPause
                              ),
                          ),
                          InkWell(
                            autofocus: false,
                            onFocusChange: onFocusChangeStopIcon,
                            child: IconButton(
                              iconSize: 50,
                              icon: Icon(Icons.stop, color: _stopColor,),
                              autofocus: false,
                              color: Colors.red,
                              onPressed: this.stop
                            )
                          )
                        ],
                      )
                    )
                  ]
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
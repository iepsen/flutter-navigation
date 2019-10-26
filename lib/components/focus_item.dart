import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_navigation/screens/video_screen.dart';

class FocusItem extends StatefulWidget {

  FocusItem({Key key, this.title, this.description, this.imageUrl, this.videoUrl, this.autoFocus, this.onFocus, this.onTap}) : super(key: key);
  final String title;
  final String description;
  final String imageUrl;
  final String videoUrl;
  final bool autoFocus;
  final Function onFocus;
  final Function onTap;

  @override
  FocusItemState createState() => FocusItemState();
}

class StateColors {
  static final Color normalColor = Color.fromRGBO(0, 0, 0, 0.6);
  static final Color focusedColor = Colors.transparent;
}

class FocusItemState extends State<FocusItem> {

  Color _foregroundColor = StateColors.normalColor;

  void onFocusChange(bool focused) {
    setState(() {
      _foregroundColor = focused ? StateColors.focusedColor : StateColors.normalColor;
    });
    if (focused) {
      onFocus();
    }
  }

  void onHover(bool focused) {
    onFocusChange(focused);
  }

  void onFocus() {
    widget.onFocus(widget.title, widget.description);
  }

  void onTap() {
    // widget.onTap(widget.videoUrl);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoScreen(videoUrl: widget.videoUrl,)),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(10),
        child: InkWell(
          autofocus: widget.autoFocus,
          splashColor: Colors.blue.withAlpha(30),
          onFocusChange: onFocusChange,
          onHover: onHover,
          onTap: onTap,
          child: Container(
            width: 360,
            padding: EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomCenter,
            foregroundDecoration: BoxDecoration(
              color: _foregroundColor,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.imageUrl),
              )
            ),
          ),
        ),
      ),
    );
  }}
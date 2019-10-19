import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FocusItem extends StatefulWidget {

  FocusItem({Key key, this.title, this.image}) : super(key: key);
  final String title;
  final String image;

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
    Color stateColor;

    if (focused) {
      stateColor = StateColors.focusedColor;
    } else {
      stateColor = StateColors.normalColor;
    }
    setState(() {
      _foregroundColor = stateColor;
    });
  }

  void onHover(bool focused) {
    onFocusChange(focused);
  }

  void onTap() {
    debugPrint('Selected content: ${widget.title}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(10),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onFocusChange: onFocusChange,
          onHover: onHover,
          onTap: onTap,
          child: Container(
            foregroundDecoration: BoxDecoration(
              color: _foregroundColor,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.image)
              )
            ),
            width: 400,
            height: 260,
            padding: EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomCenter,
            child: Text(
              widget.title.toUpperCase(),
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }}
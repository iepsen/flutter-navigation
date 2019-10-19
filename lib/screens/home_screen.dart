import 'package:flutter/material.dart';
import 'package:flutter_navigation/navigation/handle_key_press.dart';
import '../models/photo.dart';
import '../components/focus_item.dart';
import '../services/fetch_photos.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomeScreen> {
  ScrollController controller;
  HandleKeyPress handleKeyPress;
  Future<List<Photo>> photos;
  
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    handleKeyPress = HandleKeyPress(controller);
    photos = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
              height: 20,
              margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: new Text(
                'Random Images'.toUpperCase(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            new Flexible(
              child: Container(
                height: 270,
                child: DefaultFocusTraversal(
                  policy: ReadingOrderTraversalPolicy(),
                  child: FocusScope(
                    autofocus: true,
                    onKey: handleKeyPress.onKey,
                    debugLabel: 'Scope',
                    child: FutureBuilder<List<Photo>>(
                      future: photos,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<FocusItem> items = [];
                          snapshot.data.asMap().forEach((index, item) {
                            FocusItem focusItem = FocusItem(title: item.author, image: item.imageUrl, autoFocus: index == 0,);
                            items.add(focusItem);                            
                          });
                          return ListView(
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: false,
                            children: items
                          );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return new Center(child: CircularProgressIndicator());
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
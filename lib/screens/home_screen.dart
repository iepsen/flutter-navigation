import 'package:flutter/material.dart';
import 'package:flutter_navigation/navigation/handle_key_press.dart';
import '../models/video.dart';
import '../components/focus_item.dart';
import '../services/fetch_videos.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  ScrollController controller;
  HandleKeyPress handleKeyPress;
  Future<List<Video>> videos;
  String _title = '';
  String _description = '';
  
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    handleKeyPress = HandleKeyPress(controller);
    videos = VideoService().fetchVideos();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onFocus(String title, String description) {
    setState(() {
      _title = title;
      _description = description;
    });
  }

  void onTap(String videoUrl) {
    debugPrint(videoUrl);
    /*
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoScreen(videoUrl: videoUrl,)),
    );
    */
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
              margin: EdgeInsets.only(left: 30, right: 60, top: 10, bottom: 10),
              child: Text(
                _title,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.only(left: 30, right: 60, top: 10, bottom: 10),
              width: 600,
              height: 300,
              child: Text(
                _description,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            new Container(
              height: 30,
              margin: EdgeInsets.only(left: 30, top: 10, bottom: 10),
              child: new Text(
                'FOX News Clips'.toUpperCase(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            new Flexible(
              child: Container(
                height: 220,
                child: DefaultFocusTraversal(
                  policy: ReadingOrderTraversalPolicy(),
                  child: FocusScope(
                    autofocus: true,
                    onKey: handleKeyPress.onKey,
                    debugLabel: 'Scope',
                    child: FutureBuilder<List<Video>>(
                      future: videos,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<FocusItem> items = [];
                          snapshot.data.asMap().forEach((index, item) {
                            FocusItem focusItem = FocusItem(
                              title: item.title,
                              description: item.description,
                              imageUrl: item.imageUrl,
                              videoUrl: item.videoUrl,
                              autoFocus: index == 0,
                              onFocus: this.onFocus
                            );
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
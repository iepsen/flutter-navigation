import 'dart:convert';
import 'dart:math';
import 'package:fluttertv/photo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'focus_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
      home: MyHomePage(title: 'Navigation Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<MyHomePage> {
  ScrollController controller;
  Future<List<Photo>> photos;
  
  @override
  void initState() {
    controller = ScrollController();
    super.initState();
    photos = fetchPhotos();
  }

  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get('https://picsum.photos/v2/list');

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Photo.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool handleKeyPress(FocusNode node, RawKeyEvent event) {
      if (event is RawKeyDownEvent) {
        if (event.logicalKey != LogicalKeyboardKey.arrowLeft &&
          event.logicalKey != LogicalKeyboardKey.arrowRight) {
            return false;
        }

        final focusedChild = node.nearestScope.focusedChild;

        if (focusedChild == null) {
          return false;
        }

        double scrollTo;
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          node.focusInDirection(TraversalDirection.left);
          scrollTo = max(controller.offset - focusedChild.size.width - 20, 0);
        }
        if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          node.focusInDirection(TraversalDirection.right);
          scrollTo = max(controller.offset + focusedChild.size.width + 20, 0);
        }
        controller.animateTo(scrollTo, duration: new Duration(milliseconds: 300), curve: Curves.ease);
        return true;
      }
      return false;
    }

    return Scaffold(
      body: new Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    onKey: handleKeyPress,
                    debugLabel: 'Scope',
                    child: FutureBuilder<List<Photo>>(
                      future: photos,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView(
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: false,
                            children: snapshot.data.map((model) => 
                              FocusItem(title: model.author, image: model.imageUrl)).toList()
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
      )
    );
  }
}

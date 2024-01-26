import 'package:example/story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_storyboard/flutter_instagram_storyboard.dart';
import 'package:flutter_svg/svg.dart';
import 'package:story_view/story_view.dart';

import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const StoryExamplePage(),
    );
  }
}

class StoryExamplePage extends StatefulWidget {
  const StoryExamplePage({
    Key key,
  }) : super(key: key);

  @override
  State<StoryExamplePage> createState() => _StoryExamplePageState();
}

class _StoryExamplePageState extends State<StoryExamplePage> {
  List<Story> stories = [];
  Map<User, List<StoryItem>> storyItems = {};
  static const double _borderRadius = 100.0;
  final StoryTimelineController _controller = StoryTimelineController();

  Widget _createDummyPage({
    @required StoryItem storyItem,
    bool addBottomBar = true,
  }) {
    return StoryPageScaffold(
      body: Stack(
        children: [
          storyItem.view,
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black38, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 64.0, right: 8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Column(children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                            Text(
                              "1",
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(children: [
                            Icon(
                              Icons.remove_red_eye_outlined,
                            ),
                            Text(
                              "1",
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonChild(String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100.0,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 11.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildButtonDecoration(
    String imageName,
  ) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(_borderRadius),
      image: DecorationImage(
        image: AssetImage(
          'assets/images/$imageName.png',
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  BoxDecoration _buildBorderDecoration(Color color) {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(_borderRadius),
      ),
      border: Border.fromBorderSide(
        BorderSide(
          color: color,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Story Example'),
      ),
      body: Column(
        children: [
          StoryListView(
            listHeight: 180.0,
            pageTransform: const StoryPage3DTransform(),
            buttonDatas: [
              StoryButtonData(
                timelineBackgroundColor: Colors.red,
                buttonDecoration: _buildButtonDecoration('car'),
                child: _buildButtonChild('Want a new car?'),
                borderDecoration: _buildBorderDecoration(Colors.red),
                storyPages: [
                  StoryPageScaffold(
                    likesCount: 3,
                    watchCount: 4,
                    userLike: true,
                    text: "testo del prova",
                    textStyle: TextStyle(color: Colors.white),
                    onStoryLike: () {},
                    onWatchPress: () {},
                    body: Image.asset(
                      'assets/images/car.png',
                      fit: BoxFit.cover,
                    ),
                    favoriteIcon: Icon(Icons.favorite_border),
                    eyeIcon: Icon(Icons.remove_red_eye,color: Colors.white,),
                  )
                ],
                segmentDuration: const Duration(seconds: 3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  StoryItem getStoryItem(Story event, StoryController controller, int index) {
    StoryItem story;
    if (event.media.isVideo) {
      story = StoryItem.pageVideo(event.media.url,
          caption: event.caption,
          likes: event.likes,
          views: event.views,
          hasUserLike: false,
          controller: controller,
          shown: event.watched);
    } else {
      story = StoryItem.pageImage(
          url: event.media.wide_thumb,
          caption: event.caption,
          likes: event.likes,
          views: event.views,
          hasUserLike: false,
          controller: controller,
          shown: event.watched);
    }
    return story;
  }
}

import 'package:flutter/material.dart';

/// This scaffold has a transparent background and
/// rounded corners around its body. You don't necessarily
/// have to use this scaffold. You can use your own page structure
/// but if you're ok with this, feel free to use it as a base for
/// your story pages
class StoryPageScaffold extends StatefulWidget {
  final PreferredSizeWidget appBar;
  final Widget body;
  final int likesCount;
  final int watchCount;
  final String text;
  final bool userLike;
  final BorderRadius borderRadius;
  final TextStyle textStyle;
  final Function onStoryLike;
  final Function onWatchPress;

  const StoryPageScaffold({
    Key key,
    this.appBar,
    @required this.body,
    this.borderRadius,
    this.likesCount,
    this.watchCount,
    this.text,
    this.userLike,
    this.onStoryLike,
    this.onWatchPress,
    this.textStyle,
  }) : super(key: key);

  @override
  State<StoryPageScaffold> createState() => _StoryPageScaffoldState();
}

class _StoryPageScaffoldState extends State<StoryPageScaffold> {
  int likesCount;
  int watchCount;
  bool userLike;
  @override
  void initState() {
    likesCount = widget.likesCount;
    watchCount = widget.watchCount;
    userLike = widget.userLike;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: widget.borderRadius ??
              BorderRadius.circular(
                12.0,
              ),
          child: Stack(
            children: [
              widget.body,
              IgnorePointer(
                child: GradientTransition(
                  width: double.infinity,
                  height: 100.0,
                  baseColor: Colors.black.withOpacity(.7),
                  isReversed: true,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 20.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(widget.text,style: widget.textStyle,),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    userLike = !userLike;
                    likesCount = likesCount + (userLike ? 1 : -1);
                  });
                  widget.onStoryLike();
                },
                child: Row(children: [
                  Icon(
                    Icons.favorite,
                    color: userLike
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                  ),
                  Text(
                    "${likesCount}",
                    style: widget.textStyle,
                  ),
                ]),
              ),
              SizedBox(
                width: 30,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  widget.onWatchPress();
                },
                child: Row(children: [
                  Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    "${watchCount}",
                    style: widget.textStyle,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum GradientTransitionDirection {
  vertical,
  horizontal,
}

class GradientTransition extends StatelessWidget {
  final double width;
  final double height;
  final bool isReversed;
  final Color baseColor;
  final bool bottomPositioned;
  final GradientTransitionDirection gradientTransitionDirection;

  const GradientTransition({
    Key key,
    @required this.width,
    @required this.height,
    this.bottomPositioned = false,
    @required this.baseColor,
    this.isReversed = false,
    this.gradientTransitionDirection = GradientTransitionDirection.vertical,
  }) : super(key: key);

  AlignmentGeometry get _begin {
    if (gradientTransitionDirection == GradientTransitionDirection.vertical) {
      return Alignment.topCenter;
    }
    return Alignment.centerLeft;
  }

  AlignmentGeometry get _end {
    if (gradientTransitionDirection == GradientTransitionDirection.vertical) {
      return Alignment.bottomCenter;
    }
    return Alignment.centerRight;
  }

  List<Color> _getColors() {
    if (isReversed) {
      return [
        baseColor,
        baseColor.withOpacity(0.0),
      ];
    }
    return [
      baseColor.withOpacity(0.0),
      baseColor,
    ];
  }

  @override
  Widget build(BuildContext context) {
    var container = IgnorePointer(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getColors(),
            begin: _begin,
            end: _end,
          ),
        ),
      ),
    );
    if (bottomPositioned) {
      return Positioned(
        left: 0.0,
        right: 0.0,
        bottom: 0.0,
        child: container,
      );
    }
    return container;
  }
}

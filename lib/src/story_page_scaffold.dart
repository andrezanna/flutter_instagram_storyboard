import 'package:flutter/material.dart';

import 'story.dart';

/// This scaffold has a transparent background and
/// rounded corners around its body. You don't necessarily
/// have to use this scaffold. You can use your own page structure
/// but if you're ok with this, feel free to use it as a base for
/// your story pages
class StoryPageScaffold extends StatefulWidget {
  final Story story;
  final Function? onStoryLike;
  final Function? onSecondPressed;
  final TextStyle? captionStyle;
  final Widget? likeIcon;
  final Widget? secondIcon;

  const StoryPageScaffold(
      {Key? key,
      required this.story,
      this.onStoryLike,
      this.onSecondPressed,
        this.captionStyle,
      this.likeIcon,
      this.secondIcon})
      : super(key: key);

  @override
  State<StoryPageScaffold> createState() => _StoryPageScaffoldState();
}

class _StoryPageScaffoldState extends State<StoryPageScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            12.0,
          ),
          child: Stack(
            children: [
              widget.story.body,
              IgnorePointer(
                child: GradientTransition(
                  width: double.infinity,
                  height: 100.0,
                  baseColor: Colors.black.withOpacity(.7),
                  isReversed: true,
                ),
              ),
              Positioned(
                top: 24,
                left: 24,
                child: widget.story.userWidget ?? SizedBox(),
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
                child: Text(
                  widget.story.text ?? '',
                  style: widget.captionStyle??TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                  textScaleFactor: 1.0,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    widget.story.like = !widget.story.like;
                  });
                  if (widget.onStoryLike != null) {
                    widget.onStoryLike!();
                  }
                },
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      widget.story.like
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      BlendMode.srcIn),
                  child: widget.likeIcon,
                ),
              ),
              if (widget.secondIcon != null) ...[
                SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: () {
                    if (widget.onSecondPressed != null) {
                      widget.onSecondPressed!();
                    }
                  },
                  child: widget.secondIcon,
                ),
              ]
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
    Key? key,
    required this.width,
    required this.height,
    this.bottomPositioned = false,
    required this.baseColor,
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

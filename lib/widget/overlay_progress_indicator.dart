import 'package:flutter/material.dart';

/// A widget with a background and a progress indicator
/// to be overlaid over loading content
class OverlayProgressIndicator extends StatefulWidget {
  // ignore: public_member_api_docs
  const OverlayProgressIndicator(
      {Key key,
      this.visible = true,
      this.durationMillis = 200,
      this.backgroundColor = Colors.white})
      : super(key: key);

  // ignore: public_member_api_docs
  final bool visible;

  /// The fade in/out animation duration in milliseconds
  final int durationMillis;

  // ignore: public_member_api_docs
  final Color backgroundColor;

  @override
  _OverlayProgressIndicatorState createState() =>
      _OverlayProgressIndicatorState();
}

class _OverlayProgressIndicatorState extends State<OverlayProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // _controller = AnimationController(
    //     duration: Duration(milliseconds: widget.durationMillis), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    animation
      ..addListener(() {
        setState(() {});
      });

    if (widget.visible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return Visibility(
      visible: animation.value > 0,
      child: Opacity(
        opacity: animation.value,
        child: Container(
            color: widget.backgroundColor,
            child: const Center(child: CircularProgressIndicator())),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}

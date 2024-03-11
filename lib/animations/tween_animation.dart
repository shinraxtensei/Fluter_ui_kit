import 'package:flutter/material.dart';

class DoubleTween extends Tween<double> {
  DoubleTween({double begin = 0.0, double end = 1.0}) : super(begin: begin, end: end);

  @override
  double lerp(double t) {
    return begin! + (end! - begin!) * t;
  }
}

class CustomTweenAnimationWidget extends StatefulWidget {
  const CustomTweenAnimationWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomTweenAnimationWidgetState createState() => _CustomTweenAnimationWidgetState();
}

class _CustomTweenAnimationWidgetState extends State<CustomTweenAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = DoubleTween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _animation.value,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.blue,
      ),
    );
  }
}
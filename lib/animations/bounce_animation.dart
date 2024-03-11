import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class BouncyWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double dropHeight;

  const BouncyWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
    this.dropHeight = 300.0,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BouncyWidgetState createState() => _BouncyWidgetState();
}

class _BouncyWidgetState extends State<BouncyWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    final spring = SpringSimulation(
      const SpringDescription(
        mass: 0.5,
        stiffness:50,
        damping:8,
      ),
      0, 
      1, 
      -2 * widget.dropHeight, 
    );

    _animation = _controller.drive(
      Tween<double>(begin: -widget.dropHeight, end: 0).chain(
        CurveTween(curve: Curves.bounceOut),
      ),
    );

    _controller.animateWith(spring);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
    );
  }
}
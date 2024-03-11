import 'package:flutter/material.dart';

class ScalOnScrollWrapper extends StatefulWidget {
  const ScalOnScrollWrapper({
    super.key,
    required this.child,
    required this.scrollController,
  });

  final Widget child;
  final ScrollController scrollController;

  @override
  State<ScalOnScrollWrapper> createState() => ScalOnScrollWrapperState();
}

class ScalOnScrollWrapperState extends State<ScalOnScrollWrapper> {
  late RenderBox _renderObject; // Declare a variable to store the RenderBox

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _renderObject = context.findRenderObject() as RenderBox;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //  if (_renderObject == null) {
    //     return widget.child; // Return the child widget without scaling
    //   }

    final child = widget.child;

    final offsetY = _renderObject.localToGlobal(Offset.zero).dy;
    final screenHeight = MediaQuery.of(context).size.height;
    final hightVisible = screenHeight - offsetY;
    final widgetHeight = _renderObject.size.height;
    final howMuchVisible = (hightVisible / widgetHeight).clamp(0.0, 1.0);
    final scale = 0.8 + (howMuchVisible * 0.2);
    final opacity = 0.25 + (howMuchVisible * 0.75);

    return Transform.scale(
      alignment: Alignment.center,
      scale: scale,
      child: Opacity(
        opacity: opacity,
        child: child,
      ),
    );
  }
}

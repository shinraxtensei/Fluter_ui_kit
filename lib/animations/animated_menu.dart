import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedMenu extends StatefulWidget {
  const AnimatedMenu({super.key});

  @override
  State<AnimatedMenu> createState() => AnimatedMenuState();
}

class AnimatedMenuState extends State<AnimatedMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  IconData lastIconClicked = Icons.home;

  late final Animation<double> curvedAnimation = CurvedAnimation(
    parent: animationController,
    curve: Curves.easeInOut,
  );

  final List<IconData> menuItems = [
    Icons.home,
    Icons.settings,
    Icons.notifications,
    Icons.person,
    Icons.exit_to_app,
    Icons.menu,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Flow(
        delegate: ExpandingMenuFlowDelegate(
          radius: 100,
          animation: curvedAnimation,
        ),
        // delegate: FlowMenuDelegate(
        //   animationController: animationController,
        //   curvedAnimation: curvedAnimation,
        // ),
        children: menuItems
            .map<Widget>((IconData icon) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FloatingActionButton(
                      backgroundColor:
                          lastIconClicked == icon ? Colors.blue : Colors.grey,
                      splashColor: Colors.blue.shade400,
                      onPressed: () {
                        if (icon != Icons.menu) {
                          setState(() {
                            lastIconClicked = icon;
                          });
                        }
                        animationController.status == AnimationStatus.completed
                            ? animationController.reverse()
                            : animationController.forward();
                      },
                      child: Icon(icon),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class ExpandingMenuFlowDelegate extends FlowDelegate {
  final double radius;
  final Animation<double> animation;

  ExpandingMenuFlowDelegate({
    required this.radius,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < context.childCount; i++) {
      final double angle = 2 * pi * i / context.childCount;
      final double r = radius * animation.value;
      final dx = center.dx + r * cos(angle);
      final dy = center.dy + r * sin(angle);

      context.paintChild(i, transform: Matrix4.translationValues(dx, dy, 0.0));
    }
  }

  @override
  bool shouldRepaint(ExpandingMenuFlowDelegate oldDelegate) {
    return animation != oldDelegate.animation;
  }
}


// class FlowMenuDelegate extends FlowDelegate {
//   FlowMenuDelegate({
//     required this.animationController,
//     required this.curvedAnimation,
//   }) : super(repaint: animationController);

//   final AnimationController animationController;
//   final Animation<double> curvedAnimation;

//   @override
//   bool shouldRepaint(FlowMenuDelegate oldDelegate) {
//     return animationController != oldDelegate.animationController;
//   }

//   @override
//   void paintChildren(FlowPaintingContext context) {
//     double dx = 10.0;
//     for (int i = 0; i < context.childCount; i++) {
//       dx = context.getChildSize(i)!.width * i;
//       context.paintChild(i,
//           transform:
//               Matrix4.translationValues(dx * curvedAnimation.value, 0, 0));
//     }
//   } 
// }
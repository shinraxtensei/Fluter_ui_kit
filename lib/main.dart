import 'package:fluter_ui_kit/animations/animated_menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home : Padding(
          padding:  const EdgeInsets.all(5.0),
          child:  Transform.scale(
            scale: 0.9,
            child: const Align(
                alignment: Alignment.bottomCenter,
              child:  AnimatedMenu()),
          ),
        ));
  }
}

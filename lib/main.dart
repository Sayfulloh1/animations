import 'package:animations/3d_animation.dart';
import 'package:animations/hero_animation.dart';
import 'package:animations/rotate_square_animation.dart';
import 'package:animations/two_circle_half_animations_two_axis_simult.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstScreen(),
      // initialRoute: 'secondAnimation',
      routes: {
        '/firstAnimation':(context)=>RotateSquare(),
        '/secondAnimation':(context)=>TwoHalfCircleAnimations(),
      },
    );
  }
}
